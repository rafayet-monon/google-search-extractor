class SearchResult < ApplicationRecord
  belongs_to :search_file, dependent: :destroy

  validates_presence_of :key, :results, :links, :ad_words, :html
end
