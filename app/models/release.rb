class Release < ApplicationRecord
  belongs_to :asset
  belongs_to :user

  enum status: [:pending, :done, :rejected]

  def as_json(options = {})
    super(options).merge(
      created_at: created_at.strftime("%Y-%m-%d"),
      total_amount: (current_amount - penalty + profit).to_f,
      plan: asset.plan,
      user: user
    )
  end
end
