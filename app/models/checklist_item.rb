class ChecklistItem < ActiveRecord::Base
	belongs_to :equip_type
	has_many :answers

	validates :question, presence: true
	#validates :question, uniqueness: true
end
