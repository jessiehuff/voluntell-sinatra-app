class Volunteer < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_many :opportunities
  has_many :success_stories
  has_secure_password
end
