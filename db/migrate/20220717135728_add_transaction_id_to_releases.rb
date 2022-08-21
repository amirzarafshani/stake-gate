class AddTransactionIdToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :transaction_id, :string
  end
end
