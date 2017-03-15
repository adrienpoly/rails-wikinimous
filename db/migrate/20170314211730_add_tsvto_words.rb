class AddTsvtoWords < ActiveRecord::Migration[5.0]
  def up
    add_column :words, :tsv_word, :tsvector
    add_index :words, :tsv_word, using: "gin"

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON words FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv_word, 'pg_catalog.simple', word
      );
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE words SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON words
    SQL

    remove_index :words, :tsv_word
    remove_column :words, :tsv_word
  end
end
