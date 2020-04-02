class ReportServiceWithNakama
  include ServiceNakama

  InvalidDateRange = Class.new(StandardError)

  def initialize(params, user)
    @params = params
    @user   = user
  end

  # retrieving the search results and filter by date if @params[:daterange] present.
  def perform
    data = SearchResult.joins(search_file: :user)
             .where('users.id = ?', @user.id)
             .select(:id, :key, :links, :ad_words, :results)
             .order('key')
    data = filter_by_date(data) if @params[:daterange].present? # filter by  date

    data # returns ReportService with readable data and error.
  end


  private

  # filter the query byr date.
  def filter_by_date(data)
    start_date, end_date = parse_daterange

    data.where('search_files.created_at BETWEEN ? AND ?', start_date, end_date)
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
    raise_invalid_date_range if %r{(\d{4}/\d{2}/\d{2})}.match(string).blank?

    Date.strptime(string, '%Y/%m/%d')
  rescue ArgumentError
    raise_invalid_date_range
  end

  def raise_invalid_date_range
    raise InvalidDateRange, 'Select a valid daterange!'
  end
end