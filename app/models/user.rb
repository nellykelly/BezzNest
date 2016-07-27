class User < ActiveRecord::Base
	validates_uniqueness_of :login
	def passsword_valid(password)
		puts "yoloyoloyoloyoloyoloyoloyoloyoloyoloyoloyoloyoloyolo"
		puts password
		if(Digest::SHA1.hexdigest(salt.to_s + password)) == self.password_digest
			return true
		else
			return false
		end	
	end

	def count_new_notifications
		count = 0
		for notification in self.notifications
			if !notification.viewed
				count += 1
			end
		end
		return count
	end
	#This is where we make sure that the user imput something, cannot be blank
	validates :login, presence: true
	validates :password_digest, presence: true 
	validates :company_name, presence: true 
	validates :company_type, presence: true
	validates :year_founded, presence: true
	has_many :posts
	has_many :comments
	has_many :notifications


	has_and_belongs_to_many :friends, 
              class_name: "User", 
              join_table: :friendships, 
              foreign_key: :user_id, 
              association_foreign_key: :friend_user_id


	#def self.search(search)
 	# 	if search
   	# 		find(:all, :conditions => ['users.login LIKE ?', "%#{search}%"])
  	#	else
    #		find(:all)
  	#	end
	#end
end
