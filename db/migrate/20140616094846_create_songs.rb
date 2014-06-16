class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :author
      t.text :content
      t.string :key
      t.string :ccli
      t.decimal :body_font_size
      t.text :version_comment
      t.string :copyright

      t.timestamps
    end
  end
end
