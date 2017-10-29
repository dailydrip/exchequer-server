class LineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :offer, optional: true
  belongs_to :coupon, optional: true
end
