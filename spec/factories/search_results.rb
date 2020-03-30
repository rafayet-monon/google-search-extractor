FactoryBot.define do
  factory :search_result, class: SearchResult do
    association :search_file
    key { 'project management' }
    ad_words { 2 }
    links { 168 }
    results { 'About 4,070,000,000 results (0.61 seconds)' }
    html { '<html><body></body></html>' }
  end
end
