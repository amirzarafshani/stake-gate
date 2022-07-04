class UserTransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :action, :status
  has_one :user
  has_one :plan
end
