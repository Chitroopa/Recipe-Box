class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  has_and_belongs_to_many(:ingredients)
  validates(:name, :instruction, :rating, {:presence => true})

  def self.sort_by_rating()
    recipes = Recipe.all()
    recipes_rating = recipes.sort_by(&:rating).reverse
    return recipes_rating
  end
end
