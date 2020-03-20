class SearchFile < ApplicationRecord
  after_create_commit :start_search_worker
  belongs_to :user, dependent: :destroy
  has_many :search_results

  enum status: { initialized: 0, running: 1, retring: 2, completed: 3, failed: 4 }

  private

  def start_search_worker
    FileProcessingWorker.perform_async(id)
  end
end
