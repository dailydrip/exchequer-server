class Payment < ApplicationRecord
  # A Payment is a single monetary transaction spent towards an invoice
  # Later this will hold all the relaveant data we get back from Spreedly
  belongs_to :invoice
  validates :invoice, presence: true
  validates :amount, presence: true
end
