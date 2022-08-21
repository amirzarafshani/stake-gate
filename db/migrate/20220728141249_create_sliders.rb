class CreateSliders < ActiveRecord::Migration[7.0]
  def change
    create_table :sliders do |t|
      t.string :name
      t.string :image
      t.integer :sort, default: 1

      t.timestamps
    end
  end
end
