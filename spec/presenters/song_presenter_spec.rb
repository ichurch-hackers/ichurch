require 'rails_helper'

describe SongPresenter do
  describe "#author_ccli" do
    it "returns the author if it is given" do
      song = Song.new(author: "TEST")
      presenter = SongPresenter.new(song, 0)

      expect(presenter.author_ccli).to eq "TEST"
    end

    it "returns the CCLI if one is given" do
      song = Song.new(ccli: "1234")

      presenter = SongPresenter.new(song, 0)
      expect(presenter.author_ccli).to eq "CCLI 1234"
    end

    it "returns both author and CCLI if both are given" do
      song = Song.new(author: "TEST", ccli: "1234")

      presenter = SongPresenter.new(song, 0)
      expect(presenter.author_ccli).to eq "TEST - CCLI 1234"
    end
  end

  describe "#to_chord_lines" do
    it "transposes chords" do
      song = SongSamples.adventure
      presenter = SongPresenter.new(song, 1)

      lines = presenter.to_chord_lines
      chords = lines.find { |css, line| css == "chords" }
      expect(chords[1]).to start_with "Bb"
    end
  end

  describe "#transpose_distances" do
    it "returns an array of chords with the distance from the current key" do
      song = SongSamples.adventure
      presenter = SongPresenter.new(song, 0)

      expect(presenter.transpose_distances).to eq [
        ["A", -7],
        ["Bb", -6],
        ["B", -5],
        ["C", -4],
        ["C#", -3],
        ["D", -2],
        ["Eb", -1],
        ["E", 0],
        ["F", 1],
        ["F#", 2],
        ["G", 3],
        ["G#", 4],
      ]
    end
  end

  describe "#key" do
    it "transposes the original key" do
      song = SongSamples.adventure
      presenter = SongPresenter.new(song, 1)
      expect(presenter.key).to eq "F"
    end
  end

  describe "#sections" do
    song = SongSamples.adventure
    presenter = SongPresenter.new(song, 0)

    raise presenter.sections.inspect
  end
end
