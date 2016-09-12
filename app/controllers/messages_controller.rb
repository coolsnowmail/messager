class MessagesController < ApplicationController
  def create
    if user_signed_in?
      @message = current_user.messages.create(post_params.slice(:sender_id, :text))
      redirect_to user_path(@message.user_id, sender_id: @message.sender_id)
    else
      @message = Message.new(post_params.merge(incoming: true))
      @message.save if @message.valid?
      User.find_by(id: @message.user_id).services.each do |service|
        auth_date = ServiceUser.find_by(user_id: @message.user_id, service_id: service.id).auth_date
        eval(service.name).new.receive(auth_date, @message.user_id)
        eval(service.name).new.send(@message, auth_date)
      end
      redirect_to sender_path(@message.sender_id, user_id: @message.user_id)
    end
  end

  private
   def post_params
     params.require(:message).permit(:text, :sender_id, :user_id, :incoming)
   end

  def user_post_params
     params.require(:message).permit(:text, :sender_id)
   end
end
