class AddViewCountToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :view_count, :integer, default: 0, null: false
  end
end
