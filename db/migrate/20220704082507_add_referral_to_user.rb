class AddReferralToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referrer_id, :integer, null: true
    add_column :users, :referral_code, :string
  end
end
