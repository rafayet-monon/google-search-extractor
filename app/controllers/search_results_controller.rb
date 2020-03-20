class SearchResultsController < ApplicationController
  before_action :set_search_result, only: %i[show destroy]

  # GET /search_results
  def index
    @search_results = SearchResult.all
  end

  # GET /search_results/1
  def show; end

  # DELETE /search_results/1
  def destroy
    @search_result.destroy
    redirect_to search_results_url, notice: 'Search result was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_search_result
    @search_result = SearchResult.find(params[:id])
  end

end
