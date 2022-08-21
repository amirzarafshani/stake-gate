class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.decimal :current_amount, precision: 8, scale: 2
      t.decimal :penalty, precision: 8, scale: 2
      t.decimal :profit, precision: 8, scale: 2
      t.integer :status
      t.references :asset, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
