class AddFtsIndexesToSongs < ActiveRecord::Migration
  def up
    execute "create index songs_title on songs using gin(to_tsvector('english', title))"
    execute "create index songs_content on songs using gin(to_tsvector('english', content))"
    execute "create index songs_author on songs using gin(to_tsvector('english', author))"
  end

  def down
    execute "drop index songs_title"
    execute "drop index songs_content"
    execute "drop index songs_author"
  end
end
