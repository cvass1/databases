require 'recipe_repository'
require 'recipe'
require 'database_connection'


def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  it 'gets all recipes' do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes.length).to eq 2

    expect(recipes[0].id).to eq 1
    expect(recipes[0].name).to eq 'Spag Bol'
    expect(recipes[0].average_cooking_time).to eq 45
    expect(recipes[0].rating).to eq  5


    expect(recipes[1].id).to eq  2
    expect(recipes[1].name).to eq  'Chilli Con Carne'
    expect(recipes[1].average_cooking_time).to eq  50
    expect(recipes[1].rating).to eq 3
  end

  it 'returns one recipe given the ID' do
    repo = RecipeRepository.new

    recipe = repo.find(1)

    expect(recipe.id).to eq 1
    expect(recipe.name).to eq 'Spag Bol'
    expect(recipe.average_cooking_time).to eq 45
    expect(recipe.rating).to eq 5
  end
end
