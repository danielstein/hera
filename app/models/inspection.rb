class Inspection < ActiveRecord::Base
	belongs_to :user
	belongs_to :equipment
	has_many :answers
  
  nested_attributes_for :answers

	validates :photo_url, presence: true
end
