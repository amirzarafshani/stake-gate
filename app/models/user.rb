class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  belongs_to :referrer, optional: true, class_name: 'User', foreign_key: :referrer_id
  has_many :referrals, class_name: 'User', foreign_key: :referrer_id
  has_many :assets, -> { active }, dependent: :destroy
  has_many :releases, dependent: :destroy
  before_create :generate_referral_code

  enum role: [:user, :admin]
  def is_active?
    return true if assets.count.positive?
    false
  end

  def active_referrals
    referrals.select {|r| r.is_active? }.count
  end

  private
  def generate_referral_code
    begin
      referral_code = SecureRandom.hex(3)
    end while User.exists?(referral_code: referral_code)
    self.referral_code = referral_code
  end
end