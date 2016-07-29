class UsersController < ApplicationController
	def login
		require_logged_out

	end
	def post_login
		user = User.find_by_login(params[:login])
		puts "yoloyoloyoloyoloyoloyoloyoloyoloyoloyoloswaasgsgdhahsddhsa"
		puts params
		if user == nil
			flash[:falure] = " bad login"			
			redirect_to(:controller => "users", :action => "login")
		elsif !user.passsword_valid(params[:user][:password]) 
			flash[:password] = "wrong passowrd"
			redirect_to(:controller => "users", :action => "login")
		else 
			flash[:success] = " Good login"
			session[:user] = user.id
			redirect_to(:controller => "users", :action => "home")

		end
	end

	def create
		#creates a --NEW-- user
		require_logged_out
		user = User.new
		user.login = params[:login]
		user.company_name = params[:company]
		user.company_type = params[:company_type]
		salt = rand
		user.salt = salt
		puts params
		user.password_digest = Digest::SHA1.hexdigest(salt.to_s + params[:user][:password]) 


		user.year_founded = params[:year_founded]

		if user.save()
			flash[:success] = " usersuccesfully created"
			session[:user] = user.id
			redirect_to(:controller => "users", :action => "home")
		else
			#need to fix this and do hat
			error_message = ""
			user.errors.each do |type, message|
				error_message += type.to_s + " : "
				error_message += message.to_s + " \n"

			end
			
			flash[:falure] = error_message
			redirect_to(:controller => "users", :action => "login")
		end
		
		
	end

	def logout
		#Logout function
		reset_session
		redirect_to(:controller => "users", :action => "login")
	end

	def home
		if require_login 
			return
		end
		puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
		@posts = (Post.all).reverse

		@user = User.find(session[:user])
		@num_new_notifications = @user.count_new_notifications
	end

	def view 
		if require_login 
			return
		end
		@user = User.find(params[:id])
		@current_user = User.find(session[:user])
		#if session[:id] == @user

		#end

	end

	def show_user
		require_login
		@users = User.all 
		
	end

	def search
		require_login
		puts params
		#User imput quired down at every .where
		@users = User.all
		if params[:search_company_name] != ""
			@users = @users.where("company_name LIKE '%#{params[:search_company_name]}%'")
		end
		if params[:search_company_type] != ""
			@users = @users.where("company_type LIKE '%#{params[:search_company_type]}%'")
		end

	end

	def new
		require_logged_out

	end

	def edit
		@users = User.find(session[:user])
	end


	def edit_update

		if User.update(session[:user], :company_name => params[:company], :company_type => params[:company_type], :year_founded => params[:year_founded])
			flash[:success] = " your profile has been updated"
		else 
			flash[:falure] = " your user update has failed"
		end
		redirect_to(:controller => "users", :action => "home")


	end

	def add_friend
		@user = User.find(session[:user])
		@friend = User.find(params[:id])
		@user.friends << @friend
		@friend.friends << @user
		user = User.find(session[:user])
		Notification.find(params[:notification]).destroy
		notification = Notification.create_notification( 3,"#{@user.company_name} accepted your friend request","/users/view/#{@user.id}", @friend.id )
		notification.save
		if @user.save
			flash[:success] = "Friend Added"
		else
			flash[:error] = "friendship failed"
		end
		redirect_to(:controller => "users", :action => "home")

	end 

	def generate_friend_request
		@user = User.find(session[:user])
		notification = Notification.create_notification(2, "You have a partnership request from #{@user.company_name}", "", params[:id] )
		notification.save
		notification.link = "/users/#{session[:user]}/add_friend?notification=#{notification.id}"
		if notification.save
			flash[:success] = "Your friend request was sent"
		else
			flash[:failure] = "your friend request failed to send"
		end
		redirect_to(:controller => "users", :action => "home")
	end





	def notifications
		if require_login
			return
		end
		user = User.find(session[:user])
		user_notifications = (user.notifications).reverse
		@new_notifications = Array.new
		@old_notifications = Array.new
		#this is where we set notifications read or not read
		for notification in user_notifications
			if !notification.viewed 
				@new_notifications << notification

				notification.viewed = true
				notification.save
			else

				@old_notifications << notification
			end
		end
	end

	def delete_notification
		Notification.find(params[:id]).destroy

		redirect_to(:controller => "users", :action => "notifications")
	end



		#The thing that checks if there is a session and requirs
	private
		def require_login
			if session[:user] == nil
					puts "require_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_login"
					flash[:falure] = " you are not logged in."
					redirect_to(:controller => "users", :action => "login")
				return true
			else
				return false
			end
		end
		#makes user unable to access login/create while logged in
		def require_logged_out
			if session[:user] != nil
				redirect_to(:controller => "users", :action => "home")

			end


		end

end