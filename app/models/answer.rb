class Answer < ActiveRecord::Base
	belongs_to :inspection
	belongs_to :checklist_item
  
  has_many :upload
end
