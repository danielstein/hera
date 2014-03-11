class Upload < ActiveRecord::Base
  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :answer
  
end
