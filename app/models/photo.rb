class Photo < ActiveRecord::Base
	has_attached_file :image
	belongs_to :posts

	validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

	has_attached_file :image, styles: { thumb: ["64x64#", :jpg] }           
end
