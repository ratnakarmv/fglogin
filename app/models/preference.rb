class Preference < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :track
end
