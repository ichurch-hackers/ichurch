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
end
