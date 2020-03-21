class SearchResultsController < ApplicationController
  before_action :set_search_result, only: :show

  # GET /search_results/1
  def show
    @html = @search_result.html
    respond_to do |format|
      format.html { render :layout => false } # your-action.html.erb
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_search_result
    @search_result = SearchResult.find(params[:id])
  end

end
