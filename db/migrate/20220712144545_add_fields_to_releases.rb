class AddFieldsToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :protocol, :string
    add_column :releases, :address, :string
  end
end
