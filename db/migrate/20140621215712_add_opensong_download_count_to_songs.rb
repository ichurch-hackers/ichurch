class AddOpensongDownloadCountToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :opensong_download_count, :integer, default: 0, null: false
  end
end
