class MessagesController < ApplicationController
  def create
    if user_signed_in?
      @message =  Message.create(post_params)
      @user = current_user
      return redirect_to user_path(@user, sender_id: @message.sender_id)
    else
      @message =  Message.new(post_params)
      @message =  Message.create(post_params) if @message.text != ""
      user = User.find_by(id: @message.user_id)
      redirect_to sender_path(@message.sender_id, user_id: @message.user_id)
      user.service_users.each do |service_user|
        service_user.time_service.each do |time_service|
          if Time.zone.now.in_time_zone(user.timezone).wday == time_service.week_day
            from = Time.zone.now.in_time_zone(user.timezone).beginning_of_day + time_service.from.hour * 3600 + time_service.from.min * 60
            till = Time.zone.now.in_time_zone(user.timezone).beginning_of_day + time_service.till.hour * 3600 + time_service.till.min * 60
            if Time.zone.now.in_time_zone(user.timezone) > from && Time.zone.now.in_time_zone(user.timezone) < till
              VKontakteService.new.send(@message, User.find_by(id: @message.user_id).services.where(name: "Vkontakte").first.service_users.first.auth_date)
            end
          end
        end
      end
    end
  end
   private
   def post_params
     params.require(:message).permit(:text, :sender_id, :user_id, :incoming)
   end
end
