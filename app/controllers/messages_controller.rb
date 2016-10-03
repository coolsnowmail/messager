class MessagesController < ApplicationController
  def create
    if user_signed_in?
      @message = current_user.messages.create(post_params.slice(:sender_id, :text))
      redirect_to user_path(@message.user_id, sender_id: @message.sender_id)
    else
      @message = Message.new(post_params.merge(incoming: true))
      if @message.valid?
        @message.save
        user = @message.user
        return render :file => '/public/user_not_found.html', status => 404, :layout => true unless user
        user.services.each do |service|
          auth_date = ServiceUser.find_by(user_id: @message.user_id, service_id: service.id).auth_date
          service.name.constantize.new.send(@message, auth_date)
        end
        redirect_to sender_path(@message.sender_id, user_id: @message.user_id)
      else
        flash[:notice] = t("your message has not been sent")
        redirect_to sender_path(session[:sender_id])
      end
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
