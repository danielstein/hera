class Inspection < ActiveRecord::Base
	belongs_to :user
	belongs_to :equipment
	has_many :answers
  
	validates :photo_url, presence: true
end
