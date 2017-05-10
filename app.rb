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
  ingredient_ids = params.fetch("ingredient_ids")
  @new_recipe = Recipe.new({:name => name, :instruction => instruction, :rating => rating})
  if @new_recipe.save()
    @new_recipe.update({:ingredient_ids => ingredient_ids})
    redirect("/")
  else
    @errors = @new_recipe
    erb(:recipe_form)
  end
end

post('/ingredients/new') do
  ingredient_name = params.fetch('ingredient-name')
  @new_ingredient = Ingredient.new({:name => ingredient_name})
  if @new_ingredient.save()
    redirect("/recipes/new")
  else
    @errors = @new_ingredient
    erb(:recipe_form)
  end
end
