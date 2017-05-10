class CreateIngredientsTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:ingredients) do |t|
      t.column(:name, :string)

      t.timestamps()
    end
    create_table(:ingredients_recipes) do |t|
      t.column(:ingredient_id, :int)
      t.column(:recipe_id, :int)

      t.timestamps()
    end
  end
end
