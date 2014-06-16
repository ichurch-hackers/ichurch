class LineParser
  def parse(line)
    type = "lyrics"

    type = "chords" if chords?(line)
    if section = section?(line)
      type = "section"
      line = section
    end

    [type, Rack::Utils.escape_html(line).gsub(" ", "&nbsp;").html_safe]
  end

  private
  def chords?(line)
    chords = line.squeeze(" ").split(" ")

    chords.all? { |chord|
      is_chord = "ABCDEFG".include?(chord[0])

      if is_chord && chord.length > 0
        is_chord = chord[1..-1] =~ /^[b|#]?([A-Za-z]*?\d?)$/
      end

      is_chord
    }
  end

  def section?(line)
    line.strip =~ /^\[(.*)\]$/
    $1
  end
end
