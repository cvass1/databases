require_relative 'database_connection'

class RecipeRepository


  def all
    # Executes the SQL query:
    # SELECT id, name, average_cooking_time, rating FROM recipes;

    # Returns an array of Recipe objects.

    sql = 'SELECT id, name, average_cooking_time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql,[])

    recipes = []

    result_set.each { |record|
      recipe = Recipe.new
      recipe.id = record['id'].to_i
      recipe.name = record['name']
      recipe.average_cooking_time = record['average_cooking_time'].to_i
      recipe.rating = record['rating'].to_i
    recipes << recipe
    }
    return recipes
  end

  def find(id)
    # Executes the SQL query:
    # id, name, average_cooking_time, rating FROM recipe WHERE id = $1;

    # Returns a single Recipe object.
    sql = 'SELECT id, name, average_cooking_time, rating FROM recipes WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql,sql_params)[0]

    recipe = Recipe.new
    recipe.id = result['id'].to_i
    recipe.name = result['name']
    recipe.average_cooking_time = result['average_cooking_time'].to_i
    recipe.rating = result['rating'].to_i
    
    return recipe
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(recipe)
  # end

  # def update(recipe)
  # end

  # def delete(recipe)
  # end
end