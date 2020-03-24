class FileProcessingWorker
  require 'csv'
  include Sidekiq::Worker

  sidekiq_retries_exhausted do |msg|
    search_file_id = msg['args'].first
    SearchFile.find(search_file_id).failed!
  end

  def perform(search_file_id)
    @search_file = SearchFile.find(search_file_id)
    @search_file.running!
    keywords = parse_file(@search_file.file_full_path)
    keywords.each { |keyword| SearchServices::Initializer.perform(keyword, @search_file) }

    @search_file.tap(&:completed!)
  end

  private

  def parse_file(search_file)
    csv           = CSV.read(search_file)
    keywords_rows = []
    csv.each { |row| keywords_rows << row }

    keywords_rows.flatten.compact
  end
end