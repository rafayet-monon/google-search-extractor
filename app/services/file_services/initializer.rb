module FileServices
  class Initializer

    InvalidFileError = Class.new(StandardError)

    attr_reader :error

    def initialize(params, user)
      @file = params[:file]
      @user = user
    end

    def perform
      begin
        check_file
        save_file_entry
      rescue InvalidFileError => e
        @error = e.message
      rescue StandardError
        @error = 'Something went wrong. Please try again!'
      end

      self
    end

    private

    def check_file
      raise InvalidFileError, 'File must be in CSV format' unless @file.content_type == 'text/csv'
    end

    def save_file_entry
      file_path = FileServices::Uploader.new(@file, upload_path).upload

      @user.search_files.create!(file_path: file_path, file_name: @file.original_filename, status: 'initialized')
    end

    def upload_path
      Rails.root.join('file_uploads', 'csv_keywords', "user_#{@user.id}")
    end
  end
end