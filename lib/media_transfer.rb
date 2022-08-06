module MediaTransfer
  require 'media_transfer/configuration'
  require 'media_transfer/copy_files'
  class Sony
    def self.call(photos_folder, videos_folder)
      CopyFiles.new(Configuration.new('DCIM', '*.{ARW,HIF,JPG}', photos_folder, true)).call
      CopyFiles.new(Configuration.new(File.join('PRIVATE', 'M4ROOT'), '*.{MP4,XML}', videos_folder, true, true)).call
    end
  end
end