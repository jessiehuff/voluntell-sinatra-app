class Opportunity < ActiveRecord::Base
  belongs_to :volunteer
  has_many :opportunity_causes
  has_many :causes, through: :opportunity_causes
end
