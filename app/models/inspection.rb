class Inspection < ActiveRecord::Base
	belongs_to :user
	belongs_to :equipment
	has_many :answers
  
	validates :photo_url, presence: true

	#mount_uploader :picture, PictureUploader
	mount_uploader :photo_url, PictureUploader
end
