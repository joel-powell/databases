require_relative "album"
require_relative "format"

class AlbumRepository
  include Format

  def all
    query = <<~SQL
      SELECT * FROM albums;
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Album.new(hash_values_to_integers(_1)) }
  end

  def find(id)
    query = <<~SQL
      SELECT * FROM albums
      WHERE id = $1;
    SQL
    result_set = DatabaseConnection.exec_params(query, [id])
    record = result_set.first
    Album.new(hash_values_to_integers(record))
  end

  def create(album)
    query = <<~SQL
      INSERT INTO albums (title, release_year, artist_id)
      VALUES ($1,$2,$3);
    SQL
    params = [album.title, album.release_year, album.artist_id]
    DatabaseConnection.exec_params(query, params)
  end
end
