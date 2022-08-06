require 'cli/ui'
require 'win32ole'
require 'fileutils'
require 'thread'

CLI::UI::StdoutRouter.enable

module MediaTransfer
  class CopyFiles
    REMOVABLE_DISK_TYPE = 1

    def initialize(config)
      @config = config
    end

    def call
      CLI::UI::Frame.open("Searching files #{@config.file_extensions} in ?:/#{@config.match_path}") do
        input_dir = find_usb_dir
        unless input_dir
          puts CLI::UI.fmt '{{red:USB disk not found}}'
          return
        end
        
        puts CLI::UI.fmt "{{green:Found USB disk #{input_dir}}}"

        files = []
        CLI::UI::Spinner.spin('Searchig files:') do |spinner|
          files = Dir[File.join(input_dir, '**', @config.file_extensions)]

          if files.empty?
            raise "#{@config.file_extensions} files not found"
          end

          spinner.update_title CLI::UI.fmt "{{green:Found #{files.count} files in #{input_dir}, #{files_size(files)}}}" # TODO: pluralize
        end

        files_by_day = files.group_by do |f|
          time = File.stat(f).mtime  # TODO: get creation time from file meta
          Time.new(time.year, time.month, time.day)
        end

        days = files_by_day.keys.minmax.compact.uniq
        folder_name = days.map { |day| day.strftime(@config.folder_format) }.join(' - ')
        dest = File.join(@config.output_dest, folder_name)

        if @config.per_day && days.count > 1
          files_by_day.each do |day, files|
            copy(files, File.join(dest, day.strftime(@config.folder_format)))
          end
        else
          copy(files, dest)
        end

        true
      end
    end

    private
      def get_usb_drive_paths
        oFS = WIN32OLE.new('Scripting.FileSystemObject')
        oDrives = oFS.Drives
        usb_drivers = []
        oDrives.each do |drive|
          usb_drivers << drive if drive.DriveType == REMOVABLE_DISK_TYPE && drive.IsReady
        end
        usb_drivers.map do |d|
          File.join(d.Path, @config.match_path)
        end.select do |match_folder|
          Dir.exist?(match_folder)
        end
      end

      def find_usb_dir
        usb_paths = get_usb_drive_paths

        if usb_paths.size > 1
          usb_dir = CLI::UI::Prompt.ask('Choose USB drive', options: usb_paths)
        else
          usb_dir = usb_paths.first
        end

        usb_dir
      end

      def files_size(files)
        bytes = files.map{ |f| File.size(f) }.inject(:+)
        "#{(bytes.to_f / 1000000).round(2)} Mb"
      end

      def copy(files, dest)
        # TODO: pluralize
        CLI::UI::Frame.open("Copy #{files.count} files to #{dest}") do
          # multithreading_copy(files, dest)

          files.each do |file|
            copy_file(file, dest)
          end
        end
      end

      def multithreading_copy(files, dest)
        mutex = Mutex.new
        queue = Queue.new
        files.each { |f| queue << f }
        # TODO: CLI::UI::SpinGroup.new
        workers = (0...[@config.threads_count, files.count].min).map do
          Thread.new do
            begin
              while file = queue.pop(true)
                copy_file(file, dest)
                mutex.synchronize do
                  # spinner.update_title "#{file} complete"
                end
              end
            rescue ThreadError
            end
          end
        end
        workers.map(&:join)
      end

      def copy_file(file, dest)
        folder = dest
        if (@config.save_subfolder)
          # TODO: make it simple
          path = file.split(File::SEPARATOR)
          base = path.take_while { |folder| folder != @config.last_match_path }
          sub_folders = path - base
          folder = File.join(folder, *sub_folders[1...-1])
        end
        CLI::UI::Spinner.spin("#{file} -> #{folder}") do |spinner|
          unless Dir.exist?(folder)
            FileUtils.mkdir_p(folder)
          end
          FileUtils.cp(file, folder)
          spinner.update_title File.join(folder, File.basename(file))
        end
      end
  end
end