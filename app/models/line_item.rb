class LineItem < ApplicationRecord
  # A LineItem is an item with amount associated with an invoice. It can optionally be a coupon.

  CouponOnlyValidBeforePayment = Class.new(StandardError)

  belongs_to :invoice
  belongs_to :offer, optional: true
  belongs_to :coupon, optional: true

  validates :invoice, presence: true
  validates :quantity, presence: true
  validates :amount, presence: true
  validate :ensure_non_dual_type
  validate :ensure_single_type

  scope :discounts, -> { where.not(coupon_id: nil) }
  scope :offers, -> { where.not(offer_id: nil) }

  def type
    coupon_id ? Coupon : Offer
  end

  def self.create_or_find_for_offer(invoice, offer)
    if offer
      LineItem.find_or_create_by(invoice: invoice,
                                 offer: offer,
                                 quantity: 1,
                                 amount: offer.amount)
    end
  end

  def self.create_or_find_for_coupon(invoice, coupon)
    if invoice.zero_transactions?
      LineItem.find_or_create_by(invoice: invoice,
                                 coupon: coupon,
                                 quantity: 1,
                                 amount: coupon.discounted_price)
    else
      raise CouponOnlyValidBeforePayment, "You can't apply a coupon after you've made a payment"
    end
  end

  private

  def ensure_non_dual_type
    return unless [self.offer, self.coupon].compact.count == 2
    errors.add(:offer, 'You may only have a single line item type.')
    errors.add(:coupon, 'You may only have a single line item type.')
  end

  def ensure_single_type
    return unless [self.offer, self.coupon].compact.count.zero?
    errors.add(:offer, 'You must have a single line item type.')
    errors.add(:coupon, 'You must have a single line item type.')
  end
end
