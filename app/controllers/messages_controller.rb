class MessagesController < ApplicationController

  def create
    if user_signed_in?
      @message =  Message.create(post_params)
      @user = current_user
      return redirect_to user_path(@user, sender_id: @message.sender_id)
    else
      @message =  Message.new(post_params)
      @message =  Message.create(post_params) if @message.text != ""
      redirect_to sender_path(@message.sender_id, user_id: @message.user_id)


      User.find(@message.user_id).service_users.each do |service_user|
        service_user.time_service.each do |time_service|
          if Time.now.wday == time_service.week_day
            from = Time.strptime(time_service.from, '%H:%M')
            till = Time.strptime(time_service.till, '%H:%M')
            if Time.now > from && Time.now < till
              VKontakteService.new.send(@message, User.find(@message.user_id).service_users.where(service_id: 1).first.auth_date)
            end
          end
        end
      end


      # VKontakteService.new.send(@message, User.find(@message.user_id).service_users.where(service_id: 1).first.auth_date)
    end
  end

   private

   def post_params
     params.require(:message).permit(:text, :sender_id, :user_id, :incoming)
   end

end
