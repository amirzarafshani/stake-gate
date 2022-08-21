class ReferralRate < ApplicationRecord
  default_scope { order(referral_count: :desc) }

  def self.rate_by_count(count)
    where('referral_count <= ?', count).first&.profit_rate
  end
end
