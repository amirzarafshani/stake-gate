class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.integer :status
      t.string  :transaction_id
      t.references :plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
