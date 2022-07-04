class UserTransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :action, :status
  has_one :plan, serializer: PlanSerializer
  has_one :user, serializer: UserSerializer
end
