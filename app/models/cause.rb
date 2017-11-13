class Cause < ActiveRecord::Base
  has_many :opportunity_causes
  has_many :opportunities, through: :opportunity_causes
  has_many :volunteers, through: :opportunities
end
