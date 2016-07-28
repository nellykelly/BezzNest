class PostsController < ApplicationController
	before_filter :require_login

	def create
		puts params

		user = User.find(session[:user])
		post = user.posts.new
		#puts "__________________________________________"
		#puts post.methods
		post.title = params[:title]
		post.content = params[:post][:content]
		
		if params[:post][:title] != nil and params[:post][:image] != nil 
			#puts "_____________________________A______A_________"
			photo = Photo.new
			photo.title = params[:post][:title]
			photo.image = params[:post][:image]
		
			post.photo=photo
		end
		puts "_________________________________________"
		puts post.photo
		if post.save()
			flash[:success] = "Your post was created"
		else
			flash[:falure] = "to create post. You have to fill out a post title and contents to post"
		end
		redirect_to(:controller => "users", :action => "home")

	end 
	def new 
		 @photo = Photo.new
	end

	def view
		@post = Post.find(params[:id])
	end







	private
		def require_login
			if session[:user] == nil
				flash[:falure] = " you gatta be logged in bro, come on now."
				redirect_to(:controller => "users", :action => "login")
			end
		end

		def photo_params
    		params.require(:photo).permit(:image, :title)
  		end
end
