class AddImageUrlToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :imageURL, :string
  end
end
