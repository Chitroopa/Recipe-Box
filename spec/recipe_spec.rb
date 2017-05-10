require('spec_helper')

describe(Recipe) do

  it("validates presence of every attribute") do
    test_recipe = Recipe.new({:name => "", :instruction => "", :rating =>5})
    expect(test_recipe.save()).to eq(false)
  end

  describe("#categories") do
    it("tells what categories are in the recipe") do
      test_recipe = Recipe.create({:name => "Butter Chicken", :instruction => "kfhkfjhffh njkhdijd jlkdjdj jojkdj jjd. ikdhdjhhf jkdj j.", :rating => 5})
      test_category = test_recipe.categories.create({:name => "Indian"})
      expect(test_recipe.categories()).to eq([test_category])
    end
  end
end
