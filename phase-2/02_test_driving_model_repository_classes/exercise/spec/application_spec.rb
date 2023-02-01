require_relative "../app"
require_relative "../lib/album_repository"
require_relative "../lib/artist_repository"

describe Application do
  describe "#run" do
    it "lists all albums" do
      io = double(:io)

      intro = <<~INTRO
        Welcome to the music library manager!

        What would you like to do?
         1 - List all albums
         2 - List all artists

      INTRO

      expect(io).to receive(:puts).with(intro).ordered
      expect(io).to receive(:print).with("Enter your choice: ").ordered
      expect(io).to receive(:gets).and_return("1").ordered

      expect(io).to receive(:puts).with("Here is the list of albums:").ordered

      expected = <<~EXPECTED.chomp
        * 1 - Doolittle
        * 2 - Surfer Rosa
        * 3 - Waterloo
        * 4 - Super Trouper
        * 5 - Bossanova
        * 6 - Lover
        * 7 - Folklore
        * 8 - I Put a Spell on You
        * 9 - Baltimore
        * 10 - Here Comes the Sun
        * 11 - Fodder on My Wings
        * 12 - Ring Ring
      EXPECTED

      expect(io).to receive(:puts).with(expected).ordered

      album_repository = AlbumRepository.new
      artist_repository = ArtistRepository.new
      database_name = "music_library"
      app = Application.new(database_name, io, album_repository, artist_repository)

      app.run
    end

    it "lists all artists" do
      io = double(:io)

      intro = <<~INTRO
        Welcome to the music library manager!

        What would you like to do?
         1 - List all albums
         2 - List all artists

      INTRO

      expect(io).to receive(:puts).with(intro).ordered
      expect(io).to receive(:print).with("Enter your choice: ").ordered
      expect(io).to receive(:gets).and_return("2").ordered

      expect(io).to receive(:puts).with("Here is the list of artists:").ordered

      expected = <<~EXPECTED.chomp
        * 1 - Pixies
        * 2 - ABBA
        * 3 - Taylor Swift
        * 4 - Nina Simone
      EXPECTED

      expect(io).to receive(:puts).with(expected).ordered

      album_repository = AlbumRepository.new
      artist_repository = ArtistRepository.new
      database_name = "music_library"
      app = Application.new(database_name, io, album_repository, artist_repository)

      app.run
    end
  end
end
