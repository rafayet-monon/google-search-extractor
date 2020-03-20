class CreateSearchFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :search_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file_name
      t.string :file_path
      t.integer :status

      t.timestamps
    end
  end
end
