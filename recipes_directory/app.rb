require_relative './lib/recipe'
require_relative './lib/recipe_repository'
require_relative './lib/database_connection'

DatabaseConnection.connect('recipes_directory')

repo = RecipeRepository.new

repo.all.each{ |recipe|
  p "#{recipe.id} - #{recipe.name} - average cooking time: #{recipe.average_cooking_time} - Rating: #{recipe.rating}"
}