class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :preferences

  serialize :lunch
  serialize :dinner

  def to_s
    customer.email
  end
end
