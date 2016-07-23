class UsersController < ApplicationController
  before_action :authenticate_user!, :vk_for_user, :destroy_sender_if_u_want_to_log_in, only: [:show]
  def index
    redirect_to user_path(current_user.id)
  end

  def show
    @vk_user_id = @user.vk_user_id
    sender_ids = current_user.messages.pluck(:sender_id).uniq
    @senders = Sender.find(sender_ids)
    unless params[:sender_id] == nil
      @users_and_senders_messages = @user.messages.for_sender(params[:sender_id])
      #@users_and_senders_messages = Message.where(user_id: @user.id, sender_id: params[:sender_id])
      @sender_message = @user.messages.build(sender_id: params[:sender_id])
    end
  end
end


  def vk_for_user
      @user = current_user
      return @url_vk = VkontakteApi.authorization_url(scope: [:notify, :offline]) if params[:vk_id] == nil && @user.vk_user_id == nil
      return @user.update_attributes(vk_user_id: params[:vk_id]) if params[:vk_id]
  end

  def destroy_sender_if_u_want_to_log_in
    if session[:sender_id]
      Sender.find(session[:sender_id]).destroy
    end
  end
