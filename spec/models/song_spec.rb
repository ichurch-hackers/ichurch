require 'rails_helper'

describe Song, :type => :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }

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

    def escape(str)
      str.gsub(" ", "&nbsp;")
    end

    it "returns an array of tuples [css : content]" do
      chord_lines = song.to_chord_lines
      expect(chord_lines).to eq [
        ["section", escape("Verse 1")],
        ["chords", escape("C   G   D")],
        ["lyrics", escape("The river in the desert")],
      ]
    end
  end
end
