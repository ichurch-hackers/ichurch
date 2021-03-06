require 'rails_helper'

describe Song, :type => :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should belong_to :user }

  it "validates key within the chromatic scale" do
    song = Song.new(key: "H")
    song.valid?
    expect(song.errors[:key]).not_to be_blank

    song.key = "G#"
    song.valid?
    expect(song.errors[:key]).to be_blank
  end

  describe "#to_chord_lines" do
    let(:song) {
      Song.new(
        content: "
[Verse 1]
C   G   D
The river in the desert
        ".strip
      )
    }

    it "returns an array of tuples [css : content]" do
      chord_lines = song.to_chord_lines
      expect(chord_lines).to eq [
        ["section", "Verse 1"],
        ["chords", "C   G   D"],
        ["lyrics", "The river in the desert"],
      ]
    end

    it "optionally transposes the chords" do
      chord_lines = song.to_chord_lines(transpose: 1)
      expect(chord_lines).to eq [
        ["section", "Verse 1"],
        ["chords", "C#  G#  Eb"],
        ["lyrics", "The river in the desert"],
      ]
    end
  end
end
