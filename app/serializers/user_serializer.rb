class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :referrer, :referral_code, :active_referrals, :register_date, :active_referrals, :asset_count, :total_assets

  has_many :referrals, serializer: ReferralSerializer

  def active_referrals
    object.active_referrals
  end

  def referrer
    object.referrer&.email
  end

  def register_date
    object.created_at.strftime('%Y-%m-%d')
  end

  def active_referrals
    object.active_referrals
  end

  def asset_count
    object.assets.size
  end

  def total_assets
    object.assets.sum(&:amount).round(2)
  end
end
