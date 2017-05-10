require('spec_helper')

describe(Category) do

  it("validates presence of name") do
    test_category = Category.new({:name => ""})
    expect(test_category.save()).to eq(false)
  end

  describe("#recipes") do
    it("tells what recipes are in the Category") do
      test_category = Category.create({:name => "Indian"})
      test_recipe = test_category.recipes.create({:name => "Butter Chicken", :instruction => "kfhkfjhffh njkhdijd jlkdjdj jojkdj jjd. ikdhdjhhf jkdj j.", :rating => 5})
      expect(test_category.recipes()).to eq([test_recipe])
    end
  end
end
