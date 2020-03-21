class HomeController < ApplicationController
  include Pagy::Backend

  def index
    results      = ReportService.new(params, current_user).perform
    @pagy, @data = pagy(results.data)

    respond_to do |format|
      if results.error.blank?
        format.html
      else
        format.html { redirect_to root_path, alert: results.error }
      end
    end
  end
end