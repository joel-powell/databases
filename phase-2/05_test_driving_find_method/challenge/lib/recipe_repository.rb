require_relative "recipe"

class RecipeRepository
  def all
    query = <<~SQL
      SELECT * FROM recipes
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Recipe.new(_1) }
  end

  def find(id)
    query = <<~SQL
      SELECT * FROM recipes
      WHERE id = $1
    SQL
    params = [id]
    result_set = DatabaseConnection.exec_params(query, params)
    record = result_set.first
    # Recipe.new(record)
    Struct.new(*record.keys.map(&:to_sym), keyword_init: true).new(record)
  end
end
