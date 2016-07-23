class SendersController < ApplicationController
  before_action :check_if_sender_has_a_session, only: [:show]

  def show
    if @sender.messages.empty?
      @user = User.find(@sender.user_id)
      @message = @sender.messages.build
    else
      @user = User.find(@sender.user_id)
      VKontakteService.new.receive(@user.vk_user_id) if @user.vk_user_id
      @message = @sender.messages.build
    end
  end

  def new
    @user_id = params[:user_id]
    @sender = Sender.new
    return redirect_to sender_path(session[:sender_id]) if session[:sender_id]
  end

  def create
    @sender = Sender.create(post_params)
    return redirect_to new_sender_path(user_id: post_params[:user_id]),:notice => @sender.errors unless @sender.persisted?
    session[:sender_id] = @sender.id
    redirect_to sender_path(@sender)
  end

  def destroy
    sender = Sender.find(session[:sender_id])
    sender.destroy
    session[:sender_id] = nil
    redirect_to new_sender_path
  end

  private
    def post_params
      params.require(:sender).permit(:name, :user_id)
    end

    def check_if_sender_has_a_session
      return redirect_to new_sender_path unless session[:sender_id]
      @sender = Sender.find(session[:sender_id])
    end
end




