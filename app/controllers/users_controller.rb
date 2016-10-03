class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @user_services = current_user.services
    @user_services_to_connect = Service.all - @user_services
    current_user.update_attributes(timezone: Time.zone.name) if current_user.timezone == nil
    sender_ids = current_user.messages.pluck(:sender_id).uniq
    @senders = Sender.find(sender_ids)
    unless params[:sender_id] == nil
      @users_and_senders_messages = @user.messages.for_sender(params[:sender_id])
      @sender_message = @user.messages.build(sender_id: params[:sender_id])
    end
  end

  def user_time_edit

  end

  def user_time_update
    user_timezone = params[:timezone].slice(12...params[:timezone].length)
    current_user.update_attributes(timezone: user_timezone)
    redirect_to user_path(current_user.id)
  end
end