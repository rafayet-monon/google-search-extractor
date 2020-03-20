class SearchFilesController < ApplicationController
  before_action :set_search_file, only: %i[show destroy]

  # GET /search_files
  def index
    @search_files = SearchFile.all
  end

  # GET /search_files/1
  def show; end

  # GET /search_files/new
  def new
    @search_file = SearchFile.new

    respond_to :js
  end

  # POST /search_files
  def create
    @search_file = FileServices::Initializer.new(search_file_params, current_user).perform

    respond_to do |format|
      if @search_file.error.blank?
        return redirect_to root_path, notice: 'Upload Successful. Report will be displayed shortly.'
      else
        format.js
      end
    end
  end

  # DELETE /search_files/1
  def destroy
    @search_file.destroy
    redirect_to search_files_url, notice: 'Search file was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_search_file
    @search_file = SearchFile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def search_file_params
    params.require(:search_file).permit(:file)
  end
end
