class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_one :photo

	validates :title, presence: true
	validates :content, presence: true
	
end
