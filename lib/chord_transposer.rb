class ChordTransposer
  SCALE = %w(A Bb B C C# D Eb E F F# G G#)

  SCALE_INTERVALS = [
    ["A", 0],
    ["A#", 1],
    ["Bb", 1],
    ["B", 2],
    ["C", 3],
    ["C#", 4],
    ["Db", 4],
    ["D", 5],
    ["D#", 6],
    ["Eb", 6],
    ["E", 7],
    ["F", 8],
    ["F#", 9],
    ["Gb", 9],
    ["G", 10],
    ["G#", 11],
    ["Ab", 11]
  ]

  def initialize(chords)
    @chords = chords
  end

  def self.distance(base, target)
    lookup = Hash[SCALE_INTERVALS]
    base_interval = lookup[base]
    target_interval = lookup[target]

    target_interval - base_interval
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
      original_chord = SCALE_INTERVALS.find { |name, int| name == chord_name }
      new_chord_name = SCALE[(original_chord[1] + intervals) % SCALE.size]
      "#{new_chord_name}#{complement}"
    end
  end
end
