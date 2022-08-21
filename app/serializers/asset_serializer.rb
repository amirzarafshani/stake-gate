class AssetSerializer < ActiveModel::Serializer
  attributes :id, :amount, :status, :transaction_id, :staked_at, :image
  has_one :plan, serializer: PlanSerializer
  has_one :user, serializer: UserSerializer

  def staked_at
    object.created_at.strftime('%Y-%m-%d')
  end
end
