require_relative "../lib/recipe_repository"

def reset_recipes_table
  seed_sql = File.read("spec/seeds_recipes.sql")
  connection = PG.connect({ host: "localhost", dbname: "recipes_directory_test" })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do
    reset_recipes_table
  end

  describe "#all" do
    it "returns all recipes" do
      repo = RecipeRepository.new

      recipes = repo.all

      expect(recipes.count).to eq(2)
      expect(recipes.first.id).to eq("1")
      expect(recipes.first.name).to eq("Pizza")
      expect(recipes.first.average_cooking_time).to eq("10")
      expect(recipes.first.rating).to eq("5")
    end
  end

  describe "#find" do
    context "given the id 1" do
      it "returns the pizza recipe" do
        repo = RecipeRepository.new

        recipe = repo.find(1)

        expect(recipe.id).to eq("1")
        expect(recipe.name).to eq("Pizza")
        expect(recipe.average_cooking_time).to eq("10")
        expect(recipe.rating).to eq("5")
      end
    end
    context "given the id 2" do
      it "returns the pasta recipe" do
        repo = RecipeRepository.new

        recipe = repo.find(2)

        expect(recipe.id).to eq("2")
        expect(recipe.name).to eq("Pasta")
        expect(recipe.average_cooking_time).to eq("20")
        expect(recipe.rating).to eq("4")
      end
    end
  end
end
