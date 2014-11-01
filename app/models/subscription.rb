class Subscription < ActiveRecord::Base
  belongs_to :customer

  has_many :preferences

  def to_s
    customer.email
  end
end
