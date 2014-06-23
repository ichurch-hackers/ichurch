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
      expect(formatter.format(song)).to eq "[Intro]
.A/C#    C#m B A B

[V1]
.C#m                   B
 Look into My eyes and say you don't believe
.A             B              C#m
 All of this I did to be with you
.C#m                 B
 Darkness in the sky as My Father cried
.     A               B             C#m
 And then He turned away and then I died

[V2]
.C#m                   B
 Look into My eyes and say you don't believe
.A             B              C#m
 All of this I did to be with you
.C#m                 B
 Darkness in the sky as My Father tried
.A             B               A
 And then He turned away and then I died

[C]
.A                           B
 Follow Me, choose to follow Me
.A                 B                  C#m
 Take a chance and place your hand in Mine
.A                    B
 Call on Me, let your life see the spring
.          A               B             C#m     C#m/D#
 Let the adventure of your life begin tonight
.        A            B             E       /F#m
 Let the rest of your life begin tonight

[V3]
. C#m                      B
 More than just to die - I came to show the way
.A               B                 C#m
 Knowing of the cost to reach you
.C#m                 B
 Darkness in the sky as My Father tried
.    A         B              A
 Giving all He had and then I died"
    end
  end
end
