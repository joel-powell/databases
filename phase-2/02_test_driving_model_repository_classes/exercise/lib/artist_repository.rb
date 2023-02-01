require_relative "artist"
require_relative "format"

class ArtistRepository
  include Format

  def all
    query = <<~SQL
      SELECT * FROM artists;
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Artist.new(hash_values_to_integers(_1)) }
  end
end
