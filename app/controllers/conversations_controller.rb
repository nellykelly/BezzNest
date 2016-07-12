class ConversationsController < ApplicationController
	before_filter :require_login
	def index 
		@users = User.all
		@conversations = Conversation.all
	end
	def create
		puts "hello"
		puts params
		if Conversation.between(params[:sender_id],params[:recipient_id]).present?
			puts "AHHHHHHH"
			@conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
		else
			puts "KDFNGLKDFNGKLNDFGLKND"
			@conversation = Conversation.create!(conversation_params)
		end
		puts "asasasasasasasasasasasasasasasasasasasasasasa"
		redirect_to conversation_messages_path(@conversation)
	end
	private
	def conversation_params
		params.permit(:sender_id, :recipient_id)
	end

	private
		def require_login
			if session[:user] == nil
				flash[:falure] = " you gatta be logged in bro, come on now."
				redirect_to(:controller => "users", :action => "login")
			end
		end

end
