class Offer < ApplicationRecord
  # An Offer is a thing people can pay towards. It has a required name and
  # description, and belongs to an application.

  # It has a due_on which is the final day it can be paid towards.

  # Non required Amount field can set a price for the offer, but also can be
  # left unset so that some one can donate any amount

  # The deferrable boolean allows multiple payments to be made against an offer
  # when true, or when false the full amount is due in a single transaction.

  belongs_to :application
  validates :name, presence: true
  validates :description, presence: true
  has_many :coupons, dependent: :destroy
end
