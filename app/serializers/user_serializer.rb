class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :referrer, :referral_code

  has_many :referrals

  def referrer
    object.referrer&.email
  end
end
