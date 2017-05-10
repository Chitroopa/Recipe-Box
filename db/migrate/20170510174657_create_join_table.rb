class CreateJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:categories_recipes) do |t|
      t.column(:category_id, :int)
      t.column(:recipe_id, :int)

      t.timestamps()
    end
  end
end
