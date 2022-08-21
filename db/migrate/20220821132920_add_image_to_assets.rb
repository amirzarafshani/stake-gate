class AddImageToAssets < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :image, :string
  end
end
