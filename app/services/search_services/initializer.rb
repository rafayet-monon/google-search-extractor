module SearchServices
  class Initializer
    def initialize(keyword, file)
      @keyword = keyword
      @file    = file
    end

    # calls the instance method perform.
    def self.perform(keyword, file)
      new(keyword, file).perform
    end

    # makes the process sleep for a random time before making a search.
    # saves the search result to database.
    def perform
      sleep rand(5..15)
      search = SearchServices::GoogleExtractor.perform(@keyword)

      save_result(search.result)
    end

    private

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