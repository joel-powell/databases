require_relative "artist"

class ArtistRepository
  def all
    query = <<~SQL
      SELECT * FROM artists;
    SQL

    result_set = DatabaseConnection.exec_params(query, [])

    result_set.map { Artist.new(_1) }
  end
end
