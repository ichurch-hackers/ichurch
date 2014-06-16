class Song < ActiveRecord::Base
  CHROMATIC_SCALE = %w(Ab A A# Bb B C C# Db D D# Eb E F F# Gb G G#)

  validates :title, :content, presence: true
  validates :key, inclusion: CHROMATIC_SCALE
end
