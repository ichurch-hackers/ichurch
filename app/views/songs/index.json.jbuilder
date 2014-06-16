json.array!(@songs) do |song|
  json.extract! song, :id, :title, :author, :content, :key, :ccli, :body_font_size, :version_comment, :copyright
  json.url song_url(song, format: :json)
end
