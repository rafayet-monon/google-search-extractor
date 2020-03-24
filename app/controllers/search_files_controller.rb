class SearchFilesController < ApplicationController

  # GET /search_files/new
  # Opens up a modal with form to upload a CSV file.
  def new
    @search_file = SearchFile.new

    respond_to :js
  end

  # POST /search_files
  # Create a file record and uploads the file to server.
  # After creating the record a ActiveRecord callback is used to
  # start a worker that processes the keywords in it.
  def create
    @search_file = FileServices::Initializer.perform(search_file_params, current_user)

    respond_to do |format|
      if @search_file.error.blank?
        return redirect_to root_path, notice: 'Upload Successful. Report will be displayed shortly.'
      else
        format.js
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def search_file_params
    params.require(:search_file).permit(:file)
  end
end
