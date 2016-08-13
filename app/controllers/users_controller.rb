class UsersController < ApplicationController
  before_action :authenticate_user!, :vk_for_user, :destroy_sender_if_u_want_to_log_in, only: [:show]
  def index
    redirect_to user_path(current_user.id)
  end

  def show
    current_user.update_attributes(timezone: Time.zone.name) if current_user.timezone == nil
    sender_ids = current_user.messages.pluck(:sender_id).uniq
    @senders = Sender.find(sender_ids)
    unless params[:sender_id] == nil
      @users_and_senders_messages = @user.messages.for_sender(params[:sender_id])
      @sender_message = @user.messages.build(sender_id: params[:sender_id])
    end
  end

  def vk_for_user
      @user = current_user
      @service_user_vk = @user.service_users.where(service_id: 1).first
      return @url_vk = VkontakteApi.authorization_url(scope: [:notify, :offline]) if params[:vk_id] == nil && @user.service_users.empty?
      if params[:vk_id]
        @service_user_vk = @user.service_users.new(auth_date: params[:vk_id], service_id: 1)
        return @service_user_vk.save until @user.service_users.where(auth_date: params[:vk_id]).present?
      end
  end

  def destroy_sender_if_u_want_to_log_in
    if session[:sender_id]
      Sender.find(session[:sender_id]).destroy
      session[:sender_id] = nil
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
