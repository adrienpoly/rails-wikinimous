class AddColumnToWord < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :word_indexed, :string
    add_index :words, :word_indexed
  end
end
