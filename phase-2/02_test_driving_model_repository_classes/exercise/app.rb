require_relative "lib/database_connection"
require_relative "lib/artist_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect("music_library")

artist_repository = ArtistRepository.new

puts artist_repository.all
