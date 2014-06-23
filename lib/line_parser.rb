class LineParser
  def initialize(transpose: 0)
    @transpose = transpose
  end

  def parse(line)
    type = "lyrics"

    if chords?(line)
      type = "chords"
      line = @transpose == 0 ? line : ChordTransposer.new(line).transpose(@transpose)
    end

    if section = section?(line)
      type = "section"
      line = section
    end

    [type, line]
  end

  private
  def chords?(line)
    chords = line.squeeze(" ").split(/ |\//).reject { |c| c.blank? }
    chords.any? && chords.all? { |chord|
      chord =~ /^[A-G][#b]{0,2}(add|aug|dim|maj|sus|m)?\d?$/
    }
  end

  def section?(line)
    line.strip =~ /^\[(.*)\]$/
    $1
  end
end
