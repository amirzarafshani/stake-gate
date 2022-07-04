class UserTransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :action, :status
  has_one :plan
  has_one :user
end
