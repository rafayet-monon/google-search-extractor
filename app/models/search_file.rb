class SearchFile < ApplicationRecord
  belongs_to :user, dependent: :destroy

  enum status: { initialized: 0, running: 1, failed: 2, completed: 3 }
end
