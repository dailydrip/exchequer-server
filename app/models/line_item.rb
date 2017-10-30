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
