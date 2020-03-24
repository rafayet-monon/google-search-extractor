class SearchFile < ApplicationRecord
  after_create_commit :start_search_worker
  belongs_to :user, dependent: :destroy
  has_many :search_results

  enum status: { initialized: 0, running: 1, completed: 2, failed: 3 }

  validates_presence_of :file_name, :file_path

  def file_full_path
    Rails.root.to_s + file_path.to_s
  end

  private

  def start_search_worker
    FileProcessingWorker.perform_async(id)
  end
end
