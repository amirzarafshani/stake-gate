class ReferralSerializer < ActiveModel::Serializer
  attributes :id, :email, :register_date

  def register_date
    object.created_at.strftime('%Y-%m-%d')
  end
end
