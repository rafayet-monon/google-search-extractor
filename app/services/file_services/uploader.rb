module FileServices
  class Uploader
    include ServiceNakama

    def initialize(file, upload_path)
      @file = file
      @path = upload_path
    end

    # uploads and return the file path to save to database
    def perform
      upload_file
    end

    private

    # uploads the file to server.
    def upload_file
      full_path = file_path.join(file_name)
      File.open(full_path, 'wb') do |file|
        file.write(@file.read)
      end

      full_path.sub(Rails.root.to_s, '')
    end

    # create the directory if doesn't exist.
    def file_path
      FileUtils.mkdir_p @path unless Dir.exist? @path

      @path
    end

    # file name with a timestamp
    def file_name
      "#{Time.current.to_i}-#{@file.original_filename}"
    end
  end
end