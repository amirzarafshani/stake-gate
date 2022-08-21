class Plan < ApplicationRecord

  enum plan_type:[:fixed, :flexible]
end
