class Song < ActiveRecord::Base
  CHROMATIC_SCALE = %w(Ab A A# Bb B C C# Db D D# Eb E F F# Gb G G#)

  validates :title, :content, presence: true
  validates :key, inclusion: CHROMATIC_SCALE

  include PgSearch
  pg_search_scope :full_search,
                  against:  [:title, :content, :author, :version_comment],
                  using:  {
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
    lines = self.content.split("\n")
    lines[2]
  end
end
