require_relative "lib/database_connection"
require_relative "lib/recipe_repository"

DatabaseConnection.connect("recipes_directory")

recipe_repository = RecipeRepository.new

recipe_repository.all.each do |recipe|
  rating = "*" * recipe.rating.to_i
  puts "#{recipe.name} | Cooking time: #{recipe.average_cooking_time} mins | Rating: #{rating}"
end
