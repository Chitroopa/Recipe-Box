require("bundler/setup")
Bundler.require(:default)
require("pry")

ENV['RACK_ENV'] = 'test'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  erb(:index)
end

get('/recipes/new') do
  @ingredients = Ingredient.all()
  @categories = Category.all()
  erb(:recipe_form)
end

get('/recipes/rating') do
  @recipes = Recipe.sort_by_rating()
  erb(:recipe_rating)
end

post('/recipes/new') do
  name = params.fetch('name')
  instruction = params.fetch('instruction')
  rating = params.fetch('rating')
  @new_recipe = Recipe.new({:name => name, :instruction => instruction, :rating => rating})
  if @new_recipe.save()
    ingredient_ids = params.fetch("ingredient_ids",nil)
    @new_recipe.update({:ingredient_ids => ingredient_ids})
    category_ids = params.fetch('category_ids', nil)
    @new_recipe.update({:category_ids => category_ids})
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

post('/categories/new') do
  category_name = params.fetch('category-name')
  @new_category = Category.new(:name => category_name)
  if @new_category.save()
    redirect("/recipes/new")
  else
    @errors = @new_category
    erb(:recipe_form)
  end
end

get('/recipes/view/:id') do
  id = params.fetch('id').to_i()
  @recipe = Recipe.find(id)
  @ingredients = Ingredient.all()
  @categories = Category.all()
  erb(:recipe)
end

delete('/recipes/view/:id') do
  id = params.fetch('id').to_i()
  @recipe = Recipe.find(id)
  @recipe.delete
  redirect("/")
end

#update rating
patch('/recipes/view/:recipe_id/edit/rating') do
  id = params.fetch('recipe_id').to_i()
  rating = params.fetch('rating')
  @recipe = Recipe.find(id)
  @recipe.update({:rating => rating})
  redirect('/recipes/view/'.concat(id.to_s()))
end

delete ('/recipes/view/:recipe_id/edit/ingredient/remove') do
  id = params.fetch('recipe_id').to_i()
  ingredient_ids = params.fetch('ingredient_ids')
  @recipe = Recipe.find(id)
  ingredient_ids.each do |ingredient|
    @recipe.ingredients.delete(ingredient)
  end
  redirect('/recipes/view/'.concat(id.to_s()))
end

patch('/recipes/view/:recipe_id/edit/ingredient/add') do
  id = params.fetch('recipe_id').to_i()
  ingredient_ids = params.fetch('ingredient_ids')
  @recipe = Recipe.find(id)
  # @recipe.update({:ingredient_ids => ingredient_ids})
  ingredient_ids.each do |ingredient_id|
    ingredient = Ingredient.find(ingredient_id.to_i())
    @recipe.ingredients.push(ingredient)
  end
  redirect('/recipes/view/'.concat(id.to_s()))
end

get('/recipes/view/:recipe_id/categories/view/:category_id') do
  category_id = params.fetch('category_id')
  @category = Category.find(category_id)
  erb(:category)
end

get('/categories') do
  @categories = Category.all()
  erb(:categories)
end

get('/categories/view/:id') do
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  @recipes = Recipe.all()
  erb(:category)
end

delete('/categories/view/:id') do
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  @category.delete
  redirect('/categories')
end

get('/categories/view/:category_id/recipes/view/:recipe_id') do
  id = params.fetch("recipe_id")
  @recipe = Recipe.find(id)
  erb(:recipe)
end

patch('/categories/view/:id') do
  category_name = params.fetch('category-name')
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  if category_name != ""
    @category.update({:name => category_name})
    erb(:category)
  else
    @errors = "Name can't be blank"
    erb(:category)
  end
end
