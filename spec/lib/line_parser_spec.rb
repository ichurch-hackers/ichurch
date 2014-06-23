require 'rails_helper'

describe LineParser do
  describe "#parse" do
    context "with valid chords" do
      it "detects a chord line" do
        line = LineParser.new.parse("Em D Fmaj7 C#")
        expect(line).to eq ["chords", "Em D Fmaj7 C#"]
      end

      it "allows a slash in chords" do
        line = LineParser.new.parse("Em/D Fmaj7 C#/F# /Gmaj7")
        expect(line).to eq ["chords", "Em/D Fmaj7 C#/F# /Gmaj7"]
      end

      it "detects power chords" do
        line = LineParser.new.parse("A5/D#")
        expect(line).to eq ["chords", "A5/D#"]
      end

      it "detects suspended chords" do
        line = LineParser.new.parse("Dsus4")
        expect(line).to eq ["chords", "Dsus4"]
      end

      it "detects augmented chords" do
        line = LineParser.new.parse("Daug")
        expect(line).to eq ["chords", "Daug"]
      end

      it "detects augmented 7th chords" do
        line = LineParser.new.parse("Daug7")
        expect(line).to eq ["chords", "Daug7"]
      end

      it "detects add chords" do
        line = LineParser.new.parse("Dadd6")
        expect(line).to eq ["chords", "Dadd6"]
      end

      it "detects diminished chords" do
        line = LineParser.new.parse("Ddim")
        expect(line).to eq ["chords", "Ddim"]
      end

      it "detects separated chords" do
        line = LineParser.new.parse("Ddim/Eb")
        expect(line).to eq ["chords", "Ddim/Eb"]
      end
    end

    context "with lyrics" do
      it "detects lyrics" do
        line = LineParser.new.parse("The river in the desert")
        expect(line).to eq ["lyrics", "The river in the desert"]
      end

      it "detects lyric words that look like chords" do
        line = LineParser.new.parse("Awesome")
        expect(line).to eq ["lyrics", "Awesome"]
      end
    end

    context "with section" do
      it "detects the section marker" do
        line = LineParser.new.parse("[Verse 1]")
        expect(line).to eq ["section", "Verse 1"]
      end
    end
  end
end
