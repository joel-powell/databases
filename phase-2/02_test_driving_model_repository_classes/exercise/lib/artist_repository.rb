require_relative "artist"

class ArtistRepository
  def all
    sql = "SELECT * FROM artists;"
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.map { Artist.new(_1) }
  end
end
