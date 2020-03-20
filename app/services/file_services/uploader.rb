module FileServices
  class Uploader
    def initialize(file, upload_path)
      @file = file
      @path = upload_path
    end

    def upload
      upload_file
    end

    private

    def upload_file
      full_path = file_path.join(file_name)
      File.open(full_path, 'wb') do |file|
        file.write(@file.read)
      end

      full_path.sub(Rails.root.to_s, '')
    end

    def file_path
      FileUtils.mkdir_p @path unless Dir.exist? @path

      @path
    end

    def file_name
      "#{Time.current.to_i}-#{@file.original_filename}"
    end
  end
end