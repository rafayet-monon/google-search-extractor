module SearchServices
  class Initializer
    def initialize(keyword, file)
      @keyword = keyword
      @file    = file
    end

    def self.perform(keyword, file)
      new(keyword, file).perform
    end

    def perform
      return if search_executed

      sleep rand(5..15)
      result = SearchServices::GoogleExtractor.perform(@keyword)

      save_result(result)
    end

    private

    def search_executed
      SearchResult.where(key: @keyword, search_file_id: @file.id).present?
    end

    def save_result(result)
      @file.search_results.create(
        key:      @keyword,
        links:    result.links,
        ad_words: result.ad_words,
        results:  result.results,
        html:     result.html
      )
    end
  end
end