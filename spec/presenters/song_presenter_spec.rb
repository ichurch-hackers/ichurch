require 'rails_helper'

describe SongPresenter do
  describe "#author_ccli" do
    it "returns the author if it is given" do
      song = Song.new(author: "TEST")
      presenter = SongPresenter.new(song)

      expect(presenter.author_ccli).to eq "TEST"
    end

    it "returns the CCLI if one is given" do
      song = Song.new(ccli: "1234")

      presenter = SongPresenter.new(song)
      expect(presenter.author_ccli).to eq "CCLI 1234"
    end

    it "returns both author and CCLI if both are given" do
      song = Song.new(author: "TEST", ccli: "1234")

      presenter = SongPresenter.new(song)
      expect(presenter.author_ccli).to eq "TEST - CCLI 1234"
    end
  end
end
