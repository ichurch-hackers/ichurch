require 'rails_helper'

describe OpensongLyricFormatter do
  let(:formatter) { OpensongLyricFormatter.new }

  describe "#format" do
    it "changes [Verse 1] to [V1]" do
      song = Song.new(content: "[Verse 1]")
      expect(formatter.format(song)).to eq "[V1]"
    end

    it "prefixes chords with '.'" do
      song = Song.new(content: "C G Em D")
      expect(formatter.format(song)).to eq ".C G Em D"
    end

    it "prefixes lyrics with a space" do
      song = Song.new(content: "These are lyrics")
      expect(formatter.format(song)).to eq " These are lyrics"
    end

    it "formats the Adventure song" do
      song = SongSamples.adventure
      expect(formatter.format(song)).to eq ""
    end
  end
end
