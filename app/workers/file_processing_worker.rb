class FileProcessingWorker
  require 'csv'
  include Sidekiq::Worker

  sidekiq_retries_exhausted do |msg|
    search_file_id = msg['args'].first
    SearchFile.find(search_file_id).failed!
  end

  def perform(search_file_id)
    begin
      @search_file = SearchFile.find(search_file_id)
      @search_file.running!
      keywords = parse_file(file)
      keywords.each { |keyword| SearchServices::Initializer.perform(keyword, @search_file) }

      @search_file.completed!
    rescue CSV::MalformedCSVError
      @search_file.failed!

      true
    end
  end

  private

  def parse_file(search_file)
    csv           = CSV.read(search_file)
    keywords_rows = []
    csv.each { |row| keywords_rows << row }

    keywords_rows.flatten.compact
  end

  def file
    Rails.root.to_s + @search_file.file_path.to_s
  end
end