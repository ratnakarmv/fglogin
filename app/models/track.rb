class Track < ActiveRecord::Base
  has_many :preferences

  def to_s
    name
  end
end
