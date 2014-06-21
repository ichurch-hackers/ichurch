class LineParser
  def initialize(transpose: 0)
    @transpose = transpose
  end

  def parse(line)
    type = "lyrics"

    if chords?(line)
      type = "chords"
      line = ChordTransposer.new(line).transpose(@transpose)
    end

    if section = section?(line)
      type = "section"
      line = section
    end

    [type, line]
  end

  private
  def chords?(line)
    chords = line.squeeze(" ").split(" ")

    chords.any? && chords.all? { |chord|
      is_chord = "ABCDEFG/".include?(chord[0])

      if is_chord && chord.length > 0
        is_chord = chord[1..-1] =~ /^[b|#]?([A-Za-z\/#]*?\d?)$/
      end

      is_chord
    }
  end

  def section?(line)
    line.strip =~ /^\[(.*)\]$/
    $1
  end
end
