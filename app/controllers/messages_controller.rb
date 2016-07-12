class MessagesController < ApplicationController
	before_filter :require_login
	
	before_action do 
		@conversation = Conversation.find(params[:conversation_id])
		
	end

	def index
		@messages = @conversation.messages
		if @messages.length > 10
			@over_ten = true
			@messages = @messages[-10..-1]
		end
		if params[:m]
			@over_ten = false
			@messages = @conversation.messages
		end
		if @messages.last
			if @messages.last.user_id != session[:user]
			 	@messages.last.read = true;
			end

		end

		@message = @conversation.messages.new

		if session[:user] ==  @conversation.sender_id 
			@user_recipient = User.find(@conversation.recipient_id)
   		else
   			@user_recipient = User.find(@conversation.sender_id)
   		end
	end

	def new
		@message = @conversation.messages.new
	end

	def create
		puts "ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"
		@message = @conversation.messages.new(message_params)
		if @message.save
			redirect_to conversation_messages_path(@conversation)
		end
	end


private
 	def message_params
  		params.require(:message).permit(:body, :user_id)
 	end


	def require_login
		if session[:user] == nil
			flash[:falure] = " you gatta be logged in bro, come on now."
			redirect_to(:controller => "users", :action => "login")
		end
	end
end