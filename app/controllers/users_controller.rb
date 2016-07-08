class UsersController < ApplicationController
	def login

	end
	def post_login
		user = User.find_by_login(params[:login])
		puts "yoloyoloyoloyoloyoloyoloyoloyoloyoloyoloswaasgsgdhahsddhsa"
		puts params
		if user == nil
			flash[:falure] = " bad login"			
			redirect_to(:controller => "users", :action => "login")
		elsif !user.passsword_valid(params[:user][:password]) 
			flash[:password] = "worng passowrd"
			redirect_to(:controller => "users", :action => "login")
		else 
			flash[:success] = " Good login"
			session[:user] = user.id
			redirect_to(:controller => "users", :action => "home")

		end
	end

	def create
		user = User.new
		user.login = params[:login]
		user.company_name = params[:company]
		salt = rand
		user.salt = salt
		user.password_digest = Digest::SHA1.hexdigest(salt.to_s + params[:password]) 

		if user.save()
			flash[:success] = " usersuccesfully created"
		else
			#need to fix this and do hat
			error_message = ""
			user.errors.each do |type, message|
				error_message += type.to_s + " : "
				error_message += message.to_s + " \n"
			end
			flash[:falure] = error_message
		end
		redirect_to(:controller => "users", :action => "login")
	end

	def logout
		reset_session
		redirect_to(:controller => "users", :action => "login")
	end
	def home
		if require_login 
			return
		end
		puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
		@posts = Post.all
		@user = User.find(session[:user])
	end
	def view 
		if require_login 
			return
		end
		@user = User.find(params[:id])
		if session[:id] == @user

		end

	end

	def show_user
		require_login
		@users = User.all 
		
	end

	def search
		require_login
  		@users = User.where("login LIKE '%#{params[:search]}%'")

	end









	private
		def require_login
			if session[:user] == nil
					puts "require_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_loginrequire_login"
					flash[:falure] = " you gatta be logged in bro, come on now."
					redirect_to(:controller => "users", :action => "login")
				return true

					puts"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
					
			else
					return false

			end

		end


end