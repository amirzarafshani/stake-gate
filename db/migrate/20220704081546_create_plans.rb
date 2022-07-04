class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.integer :days
      t.string :name
      t.integer :profit
      t.integer :penalty
      t.integer :plan_type

      t.timestamps
    end
  end
end
