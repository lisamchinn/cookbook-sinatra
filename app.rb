require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook.rb'
require_relative './models/recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :index
end
# why do we put an @here? it's not an instance variable, but we are putting an @ because we are saying that it's available for the "view" -- this is a function of Sinatra. This is how you pass variables to the view
# erb = embedded ruby. erb is a method that is rendering the view in the webpage

get '/new' do
  erb :new
end

post '/create' do
  recipe = Recipe.new(params[:recipename], params[:recipedescription], params[:recipepreptime])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/delete/:recipe_index' do
  recipe_index = params[:recipe_index].to_i
  cookbook.remove_recipe(recipe_index)
  redirect '/'
end

get '/update/:recipe_index' do
  recipe_index = params[:recipe_index].to_i
  updated_recipe = @cookbook.find(index)

  cookbook.save_recipes_to_csv

end


  def update_recipe_status
    list
    index = @view.ask_recipe_to_update
    updated_recipe = @cookbook.find(index)
    updated_recipe.change_status
    @cookbook.save_recipes_to_csv
  end

  def display_recipes_to_user(recipes)
    puts "Here are your recipes:  "
    recipes.each_with_index do |recipe, index|
      x = recipe.completed? ? "X" : " "
      puts "#{index + 1}: [#{x}] #{recipe.name}, #{recipe.prep_time}"
    end
  end

#this works because I'm saying everything that comes after the delete/ in L33 is the recipe index. Then, I am putting it through the params method, and putting in the recipe index, and converting it to an integer. Then use cookbook to remove index.

