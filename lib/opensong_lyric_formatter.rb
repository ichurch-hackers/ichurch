class OpensongLyricFormatter
  def format(song)
    song.to_chord_lines.map { |type, line|
      if type == "section"
        _, name, number = line.match(/^(.+?)(\d*?)$/).to_a
        name = name_for_section(name)
        line = "[#{name}#{number}]"
      end

      if type == "chords"
        line = ".#{line}"
      end

      if type == "lyrics"
        line = " #{line}"
      end

      line
    }.join("\n")
  end

  private
  def name_for_section(name)
    translations = {
      "verse" => "V",
      "chorus" => "C",
      "prechorus" => "PC",
      "bridge" => "B"
    }

    translations[name.strip.downcase] || name
  end
end
