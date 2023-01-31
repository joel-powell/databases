require_relative "album"

class AlbumRepository
  def all
    query = <<~SQL
      SELECT * FROM albums;
    SQL

    result_set = DatabaseConnection.exec_params(query, [])

    result_set.map { Album.new(_1) }
  end

  def find(id)
    query = <<~SQL
      SELECT * FROM albums
      WHERE id = $1;
    SQL

    result_set = DatabaseConnection.exec_params(query, [id])

    record = result_set.first

    Album.new(record)
  end
end
