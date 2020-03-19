class CreateSearchResults < ActiveRecord::Migration[6.0]
  def change
    create_table :search_results do |t|
      t.references :search_file, null: false, foreign_key: true
      t.string :key
      t.integer :ad_words
      t.integer :links
      t.string :results
      t.text :html
      t.string :response_code

      t.timestamps
    end

    add_index :search_results, :key
  end
end
