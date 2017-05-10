require('spec_helper')

describe(Ingredient) do

  it("validates presence of name") do
    test_ingredient = Ingredient.new({:name => ""})
    expect(test_ingredient.save()).to eq(false)
  end

  describe("#recipes") do
    it("tells what recipes for the ingredients") do
      test_ingredient = Ingredient.create({:name => "Butter"})
      test_recipe = test_ingredient.recipes.create({:name => "Butter Chicken", :instruction => "kfhkfjhffh njkhdijd jlkdjdj jojkdj jjd. ikdhdjhhf jkdj j.", :rating => 5})
      expect(test_ingredient.recipes()).to eq([test_recipe])
    end
  end
end
