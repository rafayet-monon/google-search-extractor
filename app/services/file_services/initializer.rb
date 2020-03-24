require 'csv'

module FileServices
  class Initializer

    InvalidFileError = Class.new(StandardError)
    InvalidCSVError  = Class.new(StandardError)

    attr_reader :error

    def initialize(params, user)
      @file = params[:file]
      @user = user
    end

    # calls the instance method perform.
    def self.perform(params, user)
      new(params, user).perform
    end

    # checks file and saves it.
    def perform
      begin
        check_file # checks if the file uploaded is valid
        save_file_entry # Uploads the file to the server and saves a entry to database
      rescue InvalidFileError, InvalidCSVError => e
        @error = e.message
      rescue StandardError
        @error = 'Something went wrong. Please try again!'
      end

      self # returns the self object with readable error if present.
    end

    private

    # checks if file is valid and readable
    def check_file
      raise InvalidFileError, 'File must be present in CSV format!' unless valid_file

      raise InvalidCSVError, 'Your CSV file type is not supported!' unless readable_file
    end

    # checks if file present and the content type
    def valid_file
      @file.present? && @file.content_type == 'text/csv'
    end

    # checks if file is CSV readable
    def readable_file
      CSV.read(@file)

      true
    rescue CSV::MalformedCSVError
      false
    end

    # uploads and saves the file to database with a status.
    def save_file_entry
      @user.search_files.create!(file_path: uploaded_file_path, file_name: @file.original_filename, status: 'initialized')
    end

    # uploads the file to server
    def uploaded_file_path
      FileServices::Uploader.perform(@file, upload_path)
    end

    # upload path for the file
    def upload_path
      Rails.root.join('file_uploads', 'csv_keywords', "user_#{@user.id}")
    end
  end
end