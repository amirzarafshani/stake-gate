class AddOtherFieldsToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :remaining, :integer
    add_column :releases, :elapsed, :integer
  end
end
