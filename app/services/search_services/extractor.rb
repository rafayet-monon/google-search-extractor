module SearchServices
  class Extractor
    require 'selenium-webdriver'

    attr_reader :ad_words, :links, :results, :html

    def initialize(keyword)
      @keyword = keyword
    end

    def perform
      @page_source = search_google
      @links       = count_links
      @results     = search_stats
      @ad_words    = ad_words_count
      @html        = html_source
      @page_source.quit

      self
    end

    private

    def search_google
      options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
      driver  = Selenium::WebDriver.for(:firefox, options: options)
      driver.get "https://www.google.com/search?q=#{@keyword}"

      driver
    end

    def count_links
      @page_source.find_elements(:tag_name, 'a').count
    rescue element_not_found
      nil
    end

    def search_stats
      @page_source.find_element(:id, 'result-stats')&.text&.strip
    rescue element_not_found
      nil
    end

    def ad_words_count
      @page_source.find_element(:class, 'ads-ad')&.find_elements(:tag_name, 'li')&.count
    rescue element_not_found
      nil
    end

    def html_source
      @page_source.page_source
    end

    def element_not_found
      Selenium::WebDriver::Error::NoSuchElementError
    end
  end
end