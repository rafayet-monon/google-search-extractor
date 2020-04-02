class HomeController < ApplicationController
  include Pagy::Backend

  # root page that shows the report of search results
  def index
    report       = ReportService.perform(params, current_user)
    @pagy, @data = pagy(report.result) # paginate using pagy gem.

    respond_to do |format|
      # check for error attribute in results object
      if report.success?
        format.html
      else
        format.html { redirect_to root_path, alert: report.error }
      end
    end
  end
end