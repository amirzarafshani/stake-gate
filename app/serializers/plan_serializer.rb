class PlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :days, :profit, :penalty, :plan_type
end
