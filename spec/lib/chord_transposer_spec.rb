require 'rails_helper'

describe ChordTransposer do
  let(:transposer) { ChordTransposer.new(chord_string) }
  let(:chord_string) { "   C/Dmaj7   Em A  F# G" }
  describe "#interval" do
    it "transposes in line" do
      expect(transposer.transpose(1)).to eq "   C#/Ebmaj7 Fm Bb G  G#"
    end
  end
end
