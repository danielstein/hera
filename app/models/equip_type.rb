class EquipType < ActiveRecord::Base
	self.inheritance_column = nil
	has_many :equipment
	has_many :checklist_items

	validates :kind, presence: true
end
