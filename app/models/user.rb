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
	validates :login, presence: true
	validates :password_digest, presence: true 
	validates :company_name, presence: true 
	has_many :posts
	has_many :comments


	#def self.search(search)
 	# 	if search
   	# 		find(:all, :conditions => ['users.login LIKE ?', "%#{search}%"])
  	#	else
    #		find(:all)
  	#	end
	#end
end
