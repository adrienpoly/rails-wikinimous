class AddTsvtoArticle < ActiveRecord::Migration[5.0]
  def up
    add_column :articles, :tsv_content, :tsvector
    add_index :articles, :tsv_content, using: "gist"

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON articles FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv_content, 'pg_catalog.simple', content
      );
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE articles SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON articles
    SQL

    remove_index :articles, :tsv_content
    remove_column :articles, :tsv_content
  end
end
