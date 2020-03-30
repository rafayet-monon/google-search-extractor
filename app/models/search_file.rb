class SearchFile < ApplicationRecord
  after_create_commit :start_search_worker
  belongs_to :user
  has_many :search_results, dependent: :destroy

  enum status: { initialized: 0, running: 1, completed: 2, failed: 3 }

  validates_presence_of :file_name, :file_path

  # returns the full file path.
  def file_full_path
    Rails.root.to_s + file_path.to_s
  end

  private

  # start file processing worker.
  def start_search_worker
    if Rails.application.credentials.dig(:heroku, Rails.env.to_sym).present?
      FileProcessingWorker.new.perform(id)
    else
      FileProcessingWorker.perform_async(id)
    end
  end
end
