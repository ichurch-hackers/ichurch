class SongPresenter < SimpleDelegator
  attr_reader :transpose_distance

  def initialize(song, transpose_distance)
    super(song)
    @transpose_distance = transpose_distance.to_i
  end

  def author_ccli
    parts = []
    parts << author if author.present?
    parts << "CCLI #{ccli}" if ccli.present?

    parts.join " - "
  end

  def key
    ChordTransposer.transpose_chord(super, transpose_distance)
  end

  def to_chord_lines
    super(transpose: transpose_distance)
  end

  def sections
    [].tap do |result|
      current_section = []
      to_chord_lines.each do |css, line|
        if current_section.any? && (css == "section" || (css == "lyrics" && line.strip.blank?))
          result << current_section
          current_section = []
        end

        current_section << [css, line]
      end

      result << current_section
    end
  end

  def transpose_distances
    ChordTransposer::SCALE.map { |note|
      distance = ChordTransposer.distance(__getobj__.key, note)
      label = note
      if distance == 0
        label = "#{label} (original)"
      end

      [label, distance]
    }
  end
end
