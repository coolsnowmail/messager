class MessagesController < ApplicationController

  def create
    @message =  Message.create(post_params)
    @user = current_user
    return redirect_to user_path(@user, sender_id: @message.sender_id) if user_signed_in?
    redirect_to sender_path(@message.sender_id)
    u = User.find(@message.user_id)
    if u.vk_user_id
      VKontakteService.new.send(@message, u.vk_user_id)
    end

  end

   private

   def post_params
     params.require(:message).permit(:text, :sender_id, :user_id, :incoming)
   end

end
