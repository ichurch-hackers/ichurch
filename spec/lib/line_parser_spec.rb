require 'rails_helper'

describe LineParser do
  describe "#parse" do
    def escape_spaces(str)
      str.gsub(" ", "&nbsp;")
    end
    context "with valid chords" do
      it "detects a chord line" do
        line = LineParser.new.parse("Em D Fmaj7 C#")
        expect(line).to eq ["chords", escape_spaces("Em D Fmaj7 C#")]
      end

      it "allows a slash in chords" do
        line = LineParser.new.parse("Em/D Fmaj7 C#/F#")
        expect(line).to eq ["chords", escape_spaces("Em&#x2F;D Fmaj7 C#&#x2F;F#")]
      end
    end

    context "with lyrics" do
      it "detects lyrics" do
        line = LineParser.new.parse("The river in the desert")
        expect(line).to eq ["lyrics", escape_spaces("The river in the desert")]
      end
    end

    context "with section" do
      it "detects the section marker" do
        line = LineParser.new.parse("[Verse 1]")
        expect(line).to eq ["section", escape_spaces("Verse 1")]
      end
    end
  end
end
