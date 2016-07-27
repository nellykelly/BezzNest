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
		puts params
		puts "ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"
		puts message_params
		@message = @conversation.messages.new(message_params)
		@user = User.find(session[:user])
		if @message.conversation.sender_id == session[:user]
			recipient_id = @message.conversation.recipient_id
		else
			recipient_id = @message.conversation.sender_id
		end
		notification = Notification.create_notification( 4,"#{@user.company_name} sent you a message","/conversations/#{@message.conversation.id}/messages", recipient_id )
		puts notification
		notification.save
		if @message.save
			redirect_to conversation_messages_path(@conversation)
		else
			flash[:falure] = " please enter your message"
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
