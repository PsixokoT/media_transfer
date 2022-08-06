module MediaTransfer
  class Configuration
    attr_accessor :match_path
    attr_accessor :file_extensions
    attr_accessor :output_dest
    attr_accessor :per_day
    attr_accessor :save_subfolder
    attr_accessor :folder_format
    attr_accessor :threads_count
    attr_accessor :batch_size

    def initialize(match_path, file_extensions, output_dest, per_day = true, save_subfolder = false, folder_format = '%Y.%m.%d', threads_count = 6, batch_size = 0)
      @match_path = match_path
      @file_extensions = file_extensions
      @output_dest = output_dest
      @per_day = per_day
      @save_subfolder = save_subfolder
      @folder_format = folder_format
      @threads_count = threads_count
      @batch_size = batch_size
    end

    def last_match_path
      @match_path.split(File::SEPARATOR).last
    end
  end
end