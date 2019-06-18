# this is my repository file
require 'csv'

class Cookbook
  def initialize(csv_file_path)
    # which loads existing Recipe from the CSV
    @csv_file_path = csv_file_path
    @recipes = []
    parsing_from_csv
  end
  # I don't need to include options, right?
  # I want to save it here, but the array is an array of instances
  # so I dont want to push this in as a string. an array of elements, of the instances of the class Recipe

  def add_recipe(recipe)
    # which adds a new recipe to the cookbook
    @recipes << recipe
    save_recipes_to_csv
  end

  def all
    # returns recipes
    @recipes
  end

  def remove_recipe(index)
    # which removes a recipe from the cookbook.
    @recipes.delete_at(index)
    save_recipes_to_csv
  end

  def save_recipes_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time]
      end
    end
  end

  def find(index)
    @recipes[index]
  end

  private

  def parsing_from_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2])
    end
  end
end

# here, i'm STORING because i'm saving TO a CSV from the array. I'm storing all of this into a CSV file
# but actually, when I initialize, I want to save all of the recipes from my CSV file INTO the array
# def parsing_from_csv_to_array





