class CommentController < ApplicationController
	before_filter :require_login
	def comment 
		comment = Comment.new
		comment.user_id = session[:user]
		comment.post_id = params[:id]
		comment.content = params[:comment] [:comment]
		post_user_id = (Post.find(comment.post_id)).user_id
		user = User.find(session[:user])
		comment_company = user.company_name
		notification = Notification.create_notification( 1,"your post got commented on by #{comment_company}","/posts/view/#{comment.post_id}", post_user_id )
		notification.save
		
		if comment.save()
			flash[:success] = ", your comment has been created"
		else
			flash[:falure] = ", your comment was not created"
		end
		
		redirect_to("/posts/view/#{comment.post_id}")

	end

private
		def require_login
			if session[:user] == nil
				flash[:falure] = " you gatta be logged in bro, come on now."
				redirect_to(:controller => "users", :action => "login")
			end
		end


end
