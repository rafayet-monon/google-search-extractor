FactoryBot.define do
  factory :search_file, class: SearchFile do
    association :user
    file_name { 'keyword.csv' }
    file_path { '/spec/files/keyword.csv' }
    status { 'initialized' }
  end
end
