class HomeController < ApplicationController
  def index
    @search_results = SearchResult.joins(search_file: :user)
                                  .where('users.id = ?', current_user.id)
                                  .select(:id, :key, :links, :ad_words, :results)
                                  .order('key')
    if params[:daterange].present?
      daterange = params[:daterange].delete(' ').split('-')
      @search_results = @search_results.where('search_files.created_at BETWEEN ? AND ?',
                            Time.parse(daterange.first).beginning_of_day, Time.parse(daterange.last).end_of_day)
    end
  end
end
