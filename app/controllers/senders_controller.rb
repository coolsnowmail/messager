class SendersController < ApplicationController
  before_action :check_if_sender_has_a_session, only: [:show]

  def show
    @user = User.find(@sender.user_id)
    @message = @sender.messages.build
  end

  def new
    @user_id = params[:user_id]
    @sender = Sender.new
    if session[:sender_id]
    @sender = Sender.find(session[:sender_id])
    redirect_to sender_path(@sender)
    end
  end

  def create
    # user_of_the_sender = User.find(post_params[:user_id])
    # all_senders_of_the_user = user_of_the_sender.senders
    # all_senders_of_the_user.each do |s|
    #   s.name
    # end
    @sender = Sender.create(post_params)
    if @sender.id != nil
      session[:sender_id] = @sender.id
      redirect_to sender_path(@sender)
    else
      redirect_to new_sender_path(user_id: post_params[:user_id]),:notice => "Имя < #{post_params[:name]} > уже занято для этого пользователя"
    end
  end

  def destroy
    sender = Sender.find(session[:sender_id])
    session[:sender_id] = nil
    sender.destroy
    redirect_to new_sender_path
  end

  private
    def post_params
      params.require(:sender).permit(:name, :user_id)
    end

    def check_if_sender_has_a_session
      if session[:sender_id] #проверяю есть ли сессия у сендера
        @sender = Sender.find(session[:sender_id]) #ищу сендера по сессии
      else
        redirect_to new_sender_path #если у сендера нет сессии перенаправляю его на создание нового сендера
      end
    end
end




