class Opportunity < ActiveRecord::Base
  belongs_to :volunteer

  def self.search(search)
    where("cause like ?", "%#{search}%")
  end
end
