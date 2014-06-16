require 'rails_helper'

describe LineParser do
  describe "#parse" do
    def escape(str)
      str.gsub(" ", "&nbsp;")
    end
    context "with valid chords" do
      it "detects a chord line" do
        line = LineParser.new.parse("Em D Fmaj7 C#")
        expect(line).to eq ["chords", escape("Em D Fmaj7 C#")]
      end
    end

    context "with lyrics" do
      it "detects lyrics" do
        line = LineParser.new.parse("The river in the desert")
        expect(line).to eq ["lyrics", escape("The river in the desert")]
      end
    end

    context "with section" do
      it "detects the section marker" do
        line = LineParser.new.parse("[Verse 1]")
        expect(line).to eq ["section", escape("Verse 1")]
      end
    end
  end
end
