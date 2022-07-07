class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :referrer, :referral_code, :active_referrals

  has_many :referrals, serializer: ReferralSerializer

  def active_referrals
    object.active_referrals
  end

  def referrer
    object.referrer&.email
  end
end
