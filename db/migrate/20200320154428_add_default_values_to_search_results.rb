class AddDefaultValuesToSearchResults < ActiveRecord::Migration[6.0]
  def up
    change_column :search_results, :links, :integer, default: 0
    change_column :search_results, :ad_words, :integer, default: 0
    change_column :search_results, :results, :string, default: 'N/A'
    remove_column :search_results, :response_code
  end

  def down
    change_column :search_results, :links, :integer, default: nil
    change_column :search_results, :ad_words, :integer, default: nil
    change_column :search_results, :results, :string, default: nil
    add_column :search_results, :response_code, :string
  end
end
