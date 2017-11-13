class OpportunityCause < ActiveRecord::Base 
  belongs_to :opportunity 
  belongs_to :cause 
end 