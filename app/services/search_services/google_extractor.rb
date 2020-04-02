module SearchServices
  class GoogleExtractor
    require 'selenium-webdriver'
    include ServiceNakama

    attr_reader :ad_words, :links, :results, :html

    def initialize(keyword)
      @keyword = keyword
    end

    # search for keyword in google and assign attributes.
    def perform
      @page_source = search_google
      @links       = count_links
      @results     = search_stats
      @ad_words    = ad_words_count
      @html        = html_source
      @page_source.quit # quits the webdriver.

      self # returns the self object with readable attribures.
    end

    private

    # open the search using selenium headless firefox.
    def search_google
      options = Selenium::WebDriver::Chrome::Options.new(args: ['-headless'])
      driver  = Selenium::WebDriver.for(:chrome, options: options)
      driver.get "https://www.google.com/search?q=#{@keyword}"

      driver
    end

    # get the total number of links in the page, return 0 if no element found.
    def count_links
      @page_source.find_elements(:tag_name, 'a').count
    rescue element_not_found
      with_zero
    end

    # get the search  stats in the page, return 0 if no element found.
    def search_stats
      @page_source.find_element(:id, 'result-stats')&.text&.strip
    rescue element_not_found
      with_zero
    end

    # get the total number of ad words count in the page, return 0 if no element found.
    def ad_words_count
      @page_source.find_element(:class, 'ads-ad')&.find_elements(:tag_name, 'li')&.count
    rescue element_not_found
      with_zero
    end

    # get the html source of the page.
    def html_source
      @page_source.page_source
    end

    # No element check
    def element_not_found
      Selenium::WebDriver::Error::NoSuchElementError
    end

    def with_zero
      0
    end
  end
end