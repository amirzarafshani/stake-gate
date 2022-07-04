class CreateUserTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_transactions do |t|
      t.decimal :amount
      t.integer :action
      t.integer :status
      t.references :plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
