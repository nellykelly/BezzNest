class Message < ActiveRecord::Base
	#validates :body, presence: true



	belongs_to :conversation	
	belongs_to :user

	validates_presence_of :body, :conversation_id, :user_id

	def message_time
		self.updated_at.localtime.to_formatted_s(:short)
	end

	
end

