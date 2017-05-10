require("bundler/setup")
Bundler.require(:default)
require("pry")

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  erb(:index)
end

get('/recipes/new') do
  @ingredients = Ingredient.all()
  erb(:recipe_form)
end

post('/recipes/new') do
  name = params.fetch('name')
  instruction = params.fetch('instruction')
  rating = params.fetch('rating')
  @new_recipe = Recipe.new({:name => name, :instruction => instruction, :rating => rating})
  if @new_recipe.save()
    redirect("/")
  else
    erb(:recipe_form)
  end
end
