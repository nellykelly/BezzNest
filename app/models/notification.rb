class Notification < ActiveRecord::Base
	belongs_to :user

	def self.create_notification(topic_id, contents, link,user_id)
		notification = Notification.new
		notification.topic_id = topic_id
		notification.contents = contents
		notification.link = link
		notification.user_id = user_id
		notification.viewed = false

		return notification
	end

end


