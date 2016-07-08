class PostsController < ApplicationController
	before_filter :require_login

	def create
		user = User.find(session[:user])
		post = user.posts.new
		post.title = params[:title]
		post.content = params[:post][:content]
		if post.save()
			flash[:success] = ""
		else
			flash[:falure] = ""
		end
		redirect_to(:controller => "users", :action => "home")

	end 









	private
		def require_login
			if session[:user] == nil
				flash[:falure] = " you gatta be logged in bro, come on now."
				redirect_to(:controller => "users", :action => "login")
			end
		end
end
