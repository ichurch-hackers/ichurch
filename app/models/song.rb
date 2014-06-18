class Song < ActiveRecord::Base
  belongs_to :user

  CHROMATIC_SCALE = %w(Ab A A# Bb B C C# Db D D# Eb E F F# Gb G G#)

  validates :title, :content, presence: true
  validates :key, inclusion: CHROMATIC_SCALE

  include PgSearch
  pg_search_scope :full_search,
                  against:  [:title, :content, :author],
                  using: {
                    tsearch: {
                      dictionary: "english",
                      prefix:   true,
                      any_word: true
                    }
                  },
                  ignoring: :accents

  def self.search(query)
    return all if query.blank?
    full_search(query)
  end

  def first_line
    to_chord_lines.find { |css, line|
      css == 'lyrics'
    }.last
  end

  def to_chord_lines(transpose: 0)
    parser = LineParser.new(transpose: transpose)
    content.split("\n").map { |line| parser.parse(line) }
  end
end
