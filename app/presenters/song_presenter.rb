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

  def to_chord_lines
    super(transpose: transpose_distance)
  end

  def transpose_distances
    ChordTransposer::SCALE.map { |note|
      [note, ChordTransposer.distance(key, note)]
    }
  end
end
