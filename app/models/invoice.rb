class Invoice < ApplicationRecord
  # An Invoice is a history of transactions towards an offer for a given user
  belongs_to :offer
  belongs_to :user

  has_many :payments, dependent: :nullify
  has_many :line_items, dependent: :nullify

  validates :offer, presence: true
  validates :user, presence: true
  validates :due_on, presence: true

  def paid_balance
    # Total of all payments towards invoice
    BigDecimal.new('0')
  end

  def subtotal
    # Total not including coupons
    # line_items.map(&:total).sum
    BigDecimal.new('0')
  end

  def total
    # final total including discounts
    # subtotal - line_items.map(&:total).sum
    BigDecimal.new('0')
  end

  def remaining_balance
    total - paid_balance
  end
end
