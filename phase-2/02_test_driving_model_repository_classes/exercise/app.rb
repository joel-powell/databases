require_relative "lib/database_connection"
require_relative "lib/album_repository"
require_relative "lib/artist_repository"

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts <<~INTRO
      Welcome to the music library manager!

      What would you like to do?
       1 - List all albums
       2 - List all artists

    INTRO
    @io.print "Enter your choice: "
    input = @io.gets.chomp.to_i

    selected = %w[albums artists][input - 1]

    @io.puts "Here is the list of #{selected}:"

    case input
    when 1
      @io.puts @album_repository.all.map { |album| "* #{album.id} - #{album.title}" }.join("\n")
    when 2
      @io.puts @artist_repository.all.map { |artist| "* #{artist.id} - #{artist.name}" }.join("\n")
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  app = Application.new(
    "music_library",
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
