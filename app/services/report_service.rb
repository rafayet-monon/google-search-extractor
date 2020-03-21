class ReportService

  InvalidDateRange = Class.new(StandardError)

  attr_reader :data, :error

  def initialize(params, user)
    @params = params
    @user   = user
  end

  def perform
    begin
      @data = SearchResult.joins(search_file: :user)
                .where('users.id = ?', @user.id)
                .select(:id, :key, :links, :ad_words, :results)
                .order('key')
      filter_by_date if @params[:daterange].present?
    rescue InvalidDateRange => e
      @error = 'Select a valid daterange.'
    end

    self
  end

  private

  def filter_by_date
    start_date, end_date = parse_daterange
    @data                = @data.where('search_files.created_at BETWEEN ? AND ?', start_date, end_date)

  end

  def parse_daterange
    from_date, to_date = @params[:daterange].delete(' ').split('-')
    start_date         = valid_date? from_date
    end_date           = valid_date? to_date

    [start_date.beginning_of_day, end_date.beginning_of_day]
  end

  def valid_date?(string)
    Date.strptime(string, '%Y/%m/%d')
  rescue ArgumentError
    raise InvalidDateRange
  end
end