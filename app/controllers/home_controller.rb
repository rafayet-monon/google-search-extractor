class HomeController < ApplicationController
  include Pagy::Backend

  # root page that shows the report of search results
  def index
    results      = ReportService.perform(params, current_user)
    @pagy, @data = pagy(results.data) # paginate using pagy gem.

    respond_to do |format|
      # check for error attribute in results object
      if results.error.blank?
        format.html
      else
        format.html { redirect_to root_path, alert: results.error }
      end
    end
  end
end