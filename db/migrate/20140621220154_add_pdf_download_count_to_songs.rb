class AddPdfDownloadCountToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :pdf_download_count, :integer, default: 0, null: false
  end
end
