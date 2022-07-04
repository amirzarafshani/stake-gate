class UserTransaction < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  enum action: [:deposit, :withdraw]
  enum status: [:pending, :done, :rejected]
end
