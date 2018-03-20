class Invoice < ApplicationRecord
  # An Invoice is a history of transactions towards an offer for a given user

  UNPAID = 'Unpaid'.freeze
  PARTIALLY_PAID = 'Partially Paid'.freeze
  PAID = 'Paid'.freeze

  belongs_to :offer
  belongs_to :user

  has_many :payments, dependent: :nullify
  has_many :line_items, dependent: :nullify

  validates :offer, presence: true
  validates :user, presence: true
  validates :due_on, presence: true

  def status
    return status_for_not_offering if offer.amount?
    status_for_offering
  end

  def applied_coupon?
    line_items.discounts.count.positive?
  end

  def self.create_with_due_on_for(offer, user)
    Invoice.create(offer: offer,
                   user: user,
                   due_on: offer.due_on || Time.zone.now)
  end

  def zero_transactions?
    payments.count.zero? && line_items.discounts.count.zero?
  end

  def balance_paid
    # Total of all payments towards invoice
    payments.map(&:amount).sum
  end

  def subtotal
    # Total not including coupons
    return line_items.offers.map(&:amount).sum if line_items.any?
    offer.amount? ? offer.amount : 0
  end

  def total
    # final total including discounts
    subtotal - discounts
  end

  def discounts
    line_items.discounts.map(&:amount).sum
  end

  def balance_remaining
    total - balance_paid
  end

  private

  def status_for_offering
    zero_transactions? ? UNPAID : PAID
  end

  def status_for_not_offering
    return PAID if balance_remaining.zero?
    return PARTIALLY_PAID if balance_remaining < total
    return UNPAID
  end
end
