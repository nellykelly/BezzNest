class CommentController < ApplicationController
	before_filter :require_login
	def comment 
		comment = Comment.new
		comment.user_id = session[:user]
		comment.post_id = params[:id]
		comment.content = params[:comment] [:comment]

		if comment.save()
			flash[:success] = ", your comment has been created"
		else
			flash[:falure] = ", your comment was not created"
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
