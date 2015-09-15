class Song < ActiveRecord::Base
  belongs_to :user

  CHROMATIC_SCALE = %w(Ab A A# Bb B C C# Db D D# Eb E F F# Gb G G#)

  validates :title, :content, presence: true
  validates :body_font_size, numericality: { greater_than_or_equal_to: 6,
                                             less_than_or_equal_to: 18 }, allow_blank: true
  validates :key, inclusion: CHROMATIC_SCALE

  include PgSearch
  pg_search_scope :full_search,
                  against: {
                    title: 'A',
                    content: 'B'
                  },
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
    (to_chord_lines.find { |css, line|
      css == 'lyrics' && line.present?
    } || []).last
  end

  def to_chord_lines(transpose: 0)
    parser = LineParser.new(transpose: transpose)
    content.split("\n").map { |line| parser.parse(line) }
  end
end
