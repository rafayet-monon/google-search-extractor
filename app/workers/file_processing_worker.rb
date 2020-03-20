class FileProcessingWorker
  require 'CSV'
  include Sidekiq::Worker

  def perform(search_file_id)
    search_file = SearchFile.find(search_file_id)
    search_file.running!
    file = Rails.root.to_s + search_file.file_path.to_s
    keywords = parse_file(file)
    keywords.each { |keyword| SearchServices::Initializer.new(keyword, search_file).perform }

    search_file.completed!
  end

  private

  def parse_file(search_file)
    csv           = CSV.read(search_file)
    keywords_rows = []
    csv.each { |row| keywords_rows << row }

    keywords_rows.flatten.compact
  end
end