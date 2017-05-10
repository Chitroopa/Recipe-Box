class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:instruction, :text)
      t.column(:rating, :int)

      t.timestamps()
    end
    create_table(:categories) do |t|
      t.column(:name, :string)

      t.timestamps()
    end
  end
end
