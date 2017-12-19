class Invoice < ApplicationRecord
  UNPAID = 'Unpaid'.freeze
  PARTIALLY_PAID = 'Partially Paid'.freeze
  PAID = 'Paid'.freeze
  # An Invoice is a history of transactions towards an offer for a given user
  belongs_to :offer
  belongs_to :user

  has_many :payments, dependent: :nullify
  has_many :line_items, dependent: :nullify

  validates :offer, presence: true
  validates :user, presence: true
  validates :due_on, presence: true

  def status
    return PAID if balance_remaining.zero?
    return PARTIALLY_PAID if balance_remaining < total
    return UNPAID if balance_remaining == total
  end

  def applied_coupon?
    line_items_discounts.count.positive?
  end

  def line_items_discounts
    line_items.where.not(coupon_id: nil)
  end

  def line_items_offers
    line_items.where.not(offer_id: nil)
  end

  def self.create_with_due_on_for(offer, user)
    Invoice.create(offer: offer,
                   user: user,
                   due_on: offer.due_on || Time.zone.now)
  end

  def zero_transactions?
    payments.count.zero? && line_items.where.not(coupon_id: nil).count.zero?
  end

  def balance_paid
    # Total of all payments towards invoice
    payments.map(&:amount).sum
  end

  def subtotal
    # Total not including coupons
    if line_items.count.positive?
      line_items.where.not(offer_id: nil).map(&:amount).sum
    else
      offer.amount
    end
  end

  def total
    # final total including discounts
    subtotal - discounts
  end

  def discounts
    # TODO: Worry with percent_off discounts
    line_items.where.not(coupon_id: nil).map(&:amount).sum
  end

  def balance_remaining
    total - balance_paid
  end
end
