class Asset < ApplicationRecord
  belongs_to :plan, optional: true
  belongs_to :user

  enum status: [:pending, :done, :rejected, :archived]

  scope :active, -> { where(status: "done") }

  def as_json(options = {})
    super(options).merge(
      staked_at: created_at.strftime("%Y-%m-%d"),
      remaining: remaining,
      release_date: release_date,
      calculated_profit: calculated_profit,
      calculated_penalty: calculated_penalty,
      profit_rate: profit_rate,
      elapsed: elapsed
    )
  end

  def release_date
    return if plan.flexible?
    created_at.to_date + plan.days
  end

  def remaining
    return 0 if plan.flexible? || Date.today > release_date
    (release_date - Date.today).to_i
  end

  def elapsed
    (Date.today - created_at.to_date).to_i
  end

  def calculated_profit
    return 0 unless elapsed
    (elapsed * amount.to_f * profit_rate).round(2)
  end

  def calculated_penalty
    return 0 unless remaining
    (remaining * amount.to_f * plan.penalty).round(2)
  end

  def profit_rate
    rate = ReferralRate::rate_by_count(user.active_referrals)
    return plan.profit + rate unless rate.nil?
    plan.profit
  end
end
