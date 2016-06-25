class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    redirect_to user_path(current_user)
  end

  def show
    @user = current_user
    if params[:vk_id] == nil && @user.vk_user_id == nil
      @url_vk = VkontakteApi.authorization_url(scope: [:notify, :offline])
    end
    if params[:vk_id]
      @user.vk_user_id = params[:vk_id]
      @user.save
    end
    @vk_user_id = @user.vk_user_id
    sender_ids = current_user.messages.pluck(:sender_id).uniq
    @senders = Sender.find(sender_ids)
    if params[:sender_id] == nil
    else
      @users_and_senders_messages = Message.where(user_id: @user.id, sender_id: params[:sender_id])
      @message_to_the_sender = @user.messages.build(sender_id: params[:sender_id])
    end
  end
end
