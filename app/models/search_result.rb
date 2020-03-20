class SearchResult < ApplicationRecord
  belongs_to :search_file, dependent: :destroy
end
