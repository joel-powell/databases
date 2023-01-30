require_relative "lib/database_connection"
require_relative "lib/artist_repository"
require_relative "lib/album_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect("music_library")

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

puts artist_repository.all
puts album_repository.all
