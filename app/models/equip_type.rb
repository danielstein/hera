class EquipType < ActiveRecord::Base
	self.inheritance_column = nil
	has_many :equipment
	has_many :checklist_items
  
  accepts_nested_attributes_for :checklist_items, allow_destroy: true

	validates :kind, presence: true
end
