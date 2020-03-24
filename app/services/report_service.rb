class ReportService

  InvalidDateRange = Class.new(StandardError)

  attr_reader :data, :error

  def initialize(params, user)
    @params = params
    @user   = user
  end

  # calls the perform instance method.
  def self.perform(params, user)
    new(params, user).perform
  end

  # retrieving the search results and filter by date if @params[:daterange] present.
  def perform
    begin
      @data = SearchResult.joins(search_file: :user)
                          .where('users.id = ?', @user.id)
                          .select(:id, :key, :links, :ad_words, :results)
                          .order('key')
      filter_by_date if @params[:daterange].present? # filter by  date
    rescue InvalidDateRange
      @error = 'Select a valid daterange!'
    end

    self # returns ReportService with readable data and error.
  end

  private

  # filter the query byr date.
  def filter_by_date
    start_date, end_date = parse_daterange

    @data = @data.where('search_files.created_at BETWEEN ? AND ?', start_date, end_date)
  end

  # parses the daterange parameter to start_date and end_date
  def parse_daterange
    from_date, to_date = @params[:daterange].delete(' ').split('-')
    start_date         = valid_date? from_date
    end_date           = valid_date? to_date

    [start_date.beginning_of_day, end_date.beginning_of_day]
  end

  # checks if date  string is valid by checking a regex and formatting date.
  # raise InvalidDateRange if something goes wrong.
  def valid_date?(string)
    raise InvalidDateRange if %r{(\d{4}/\d{2}/\d{2})}.match(string).blank?

    Date.strptime(string, '%Y/%m/%d')
  rescue ArgumentError
    raise InvalidDateRange
  end
end