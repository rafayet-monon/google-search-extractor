FactoryBot.define do
  factory :search_file, class: SearchFile do
    file_name { 'keyword.csv' }
    file_path { '/spec/csv_file/keyword.csv' }
    status { 'initialized' }
  end
end
