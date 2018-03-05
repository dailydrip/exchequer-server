class Offer < ApplicationRecord
  # An Offer is a thing people can pay towards. It has a required name and description, and belongs
  # to an application.

  # It has a due_on which is the final day it can be paid towards.

  # Non required Amount field can set a price for the offer, but also can be left unset so that some
  # one can donate any amount

  # The deferrable boolean allows multiple payments to be made against an offer when true, or when
  # false the full amount is due in a single transaction.

  DueOnExpired = Class.new(StandardError)
  DeferrableNotAllowed = Class.new(StandardError)

  belongs_to :manager
  has_many :coupons, dependent: :destroy
  has_many :invoices

  validates :manager, presence: true
  validates :name, presence: true
  validates :description, presence: true
end
