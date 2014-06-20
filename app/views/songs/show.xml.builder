xml.song do |song|
  song.title @song.title
  song.author @song.author
  song.copyright @song.copyright
  song.ccli @song.ccli
  song.key @song.key
  song.lyrics OpensongLyricFormatter.new.format(@song.__getobj__) + "\n"
end
