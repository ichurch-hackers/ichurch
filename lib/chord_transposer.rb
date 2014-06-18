class ChordTransposer
  SCALE = %w(C C# D Eb E F F# G G# A Bb B)

  def initialize(chords)
    @chords = chords
  end

  def transpose(interval)
    chord_positions = get_chord_positions
    chord_positions.each do |cp|
      cp[0] = transpose_chord(cp[0], interval)
    end

    interpolate_line chord_positions
  end

  private
  def get_chord_positions
    positions = []

    chord = ""
    start_pos = 0

    (0..@chords.length - 1).each do |i|
      if @chords[i] == ' ' && chord != ""
        positions << [chord, start_pos]
        chord = ""
        start_pos = 0
      end

      if @chords[i] != ' '
        start_pos = i if chord == ""
        chord << @chords[i]
      end
    end

    if chord != ""
      positions << [chord, start_pos]
    end

    positions
  end

  def interpolate_line(chord_positions)
    output = " " * chord_positions[-1][1]

    chord_positions.each do |chord, position|
      insert_string = chord
      if output.length < position
        output << (" " * (position - output.length))
      end
      output.insert(position, insert_string)
    end

    output.strip
  end

  def transpose_chord(chord, intervals)
    chord.gsub(/([A-G][#b]*)/) do
      chord_name, complement = $~.captures
      new_chord_name = SCALE[(SCALE.index(chord_name) + intervals) % SCALE.size]
      "#{new_chord_name}#{complement}"
    end
  end
end
