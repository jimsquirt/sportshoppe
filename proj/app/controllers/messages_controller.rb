class MessagesController < ApplicationController
  def index
  	#@messages = Message.where(:sendto_id => current_user.id).order("created_at DESC").group("sender_id")
    @messages = Message.where(:sendto_id => current_user.id).order(:sender_id)
  end

  def outbox
    @messages = Message.where(:sender_id => current_user.id).order(:sendto_id)
  end

  def create
  	@message = Message.new(params[:message])

    if @message.save
      msg = 'message was successfully sent.'
    else
      msg = 'message was not sent.'
    end
    redirect_to user_path(@message.sendto_id), notice: msg
  end

  def destroy
    @message = Message.find(params[:id])
    
    if @message.destroy
      msg = 'message was successfully deleted.'
    else
      msg = 'message could not be deleted.'
    end
    if current_user.admin
      redirect_to admin_messages_path, notice: msg
    else
      redirect_to user_messages_path(current_user.id), notice: msg
    end
  end


end
