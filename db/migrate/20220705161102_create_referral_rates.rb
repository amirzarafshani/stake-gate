class CreateReferralRates < ActiveRecord::Migration[7.0]
  def change
    create_table :referral_rates do |t|
      t.integer :referral_count
      t.float :profit_rate
      t.timestamps
    end
  end
end
