require_relative "lib/database_connection"
require_relative "lib/artist_repository"
require_relative "lib/album_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect("music_library")

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

puts "--ALL ARTISTS--"
artist_repository.all.each do |artist|
  puts "#{artist.id} - #{artist.name} - #{artist.genre}"
end

puts "--ALL ALBUMS--"
album_repository.all.each do |album|
  puts "#{album.id} - #{album.title} - #{album.release_year} - #{album.artist_id}"
end

puts "--ALBUM 3--"
album = album_repository.find(3)
puts "#{album.id} - #{album.title} - #{album.release_year} - #{album.artist_id}"
