class Building < ActiveRecord::Base
	has_many :equipment

	validates :idAtlas, uniqueness: true, presence: true
end
