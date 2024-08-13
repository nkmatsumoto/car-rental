class RemoveColumnFromCars < ActiveRecord::Migration[7.1]
  def change
    remove_column :cars, :imageURL, :string
  end
end
