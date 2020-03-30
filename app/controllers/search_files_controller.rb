class SearchFilesController < ApplicationController

  # GET /search_files/new
  # Opens up a modal with form to upload a CSV file.
  def new
    @search_file = SearchFile.new

    respond_to :html
  end

  # POST /search_files
  # Create a file record and uploads the file to server.
  # After creating the record a ActiveRecord callback is used to
  # start a worker that processes the keywords in it.
  def create
    @search_file = FileServices::Initializer.perform(search_file_params, current_user)

    respond_to do |format|
      if @search_file.error.blank?
        format.html { redirect_to root_path, notice: 'Upload Successful. Report will be displayed shortly.' }
      else
        @new_search_file = SearchFile.new
        format.html { redirect_to new_search_file_path, alert: @search_file.error }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def search_file_params
    params.require(:search_file).permit(:file)
  end
end
