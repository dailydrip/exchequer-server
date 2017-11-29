class LineItem < ApplicationRecord
  # A LineItem is an item with amount associated with an invoice.
  # It can optionally be a coupon
  belongs_to :invoice
  belongs_to :offer, optional: true
  belongs_to :coupon, optional: true
  validates :invoice, presence: true
  validates :quantity, presence: true
  validates :amount, presence: true
  validate :ensure_non_dual_type
  validate :ensure_single_type

  def self.create_if_necessary_for(invoice, offer, coupon)
    # We create a LineItem only for the offer and coupon
    # Coupons are applied only for the full price
    if offer
      LineItem.find_or_create_by(invoice: invoice,
                                 offer: offer,
                                 quantity: 1,
                                 amount: offer.amount)
    end

    if coupon
      begin
        LineItem.create_line_item_for_coupon(invoice, offer, coupon)
      rescue ArgumentError => e
        raise e
      end
    end
  end

  def self.create_line_item_for_coupon(invoice, offer, coupon)
    if invoice.zero_transactions?
      # FIXME: Need to check the amount here.
      # Will we save the amount off?
      LineItem.find_or_create_by(invoice: invoice,
                                 coupon: coupon,
                                 quantity: 1,
                                 amount: offer.amount)
    else
      raise ArgumentError, 'You can only apply the coupon in the full price'
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
