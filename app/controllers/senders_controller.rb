class SendersController < ApplicationController
  before_action :check_if_sender_has_a_session, only: [:index, :invite_link]
  def index

  end

  def invite_link
    link = params[:link]
    redirect_to link
  end

  def show
    @sender = Sender.find(session[:sender_id])
    @user = User.find(params[:user_id])
    if @sender.messages.empty?
      @message = @sender.messages.build
    else
      VKontakteService.new.receive(@user.service_users.where(service_id: 1).first.auth_date, @user.id) if @user.service_users.where(service_id: 1).first.auth_date
      @message = @sender.messages.build
    end
  end

  def new
    if session[:sender_id]
      sender = Sender.find(session[:sender_id])
      user = User.find(params[:user_id])
      if sender.users.ids.include?(user.id)
        redirect_to sender_path(session[:sender_id], user_id: user.id)
      else
        sender.users << user
        redirect_to sender_path(session[:sender_id], user_id: user.id)
      end
    end
    @user = User.find(params[:user_id])
    @sender = Sender.new
  end

  def create
    user = User.find(params[:user_id])
    @sender = user.senders.new(post_params)
    if user.senders.pluck(:name).include?(@sender.name)
      redirect_to new_sender_path(user_id: user.id), :notice => t("notice_that_this_sender_name_have_been_acupate")
    else
      if @sender.name == ""
        redirect_to new_sender_path(user_id: user.id), :notice => t("enter_ur_name")
      else
        @sender = user.senders.create(post_params)
        #redirect_to sender_path(@sender.id, user_id: user.id)
        session[:sender_id] = @sender.id
        redirect_to sender_path(session[:sender_id], user_id: user.id)
      end
    end

  end

  def destroy
    sender = Sender.find(session[:sender_id])
    change_id = rand(100000)
    sender.messages.each do |message|
      message.update_column(:sender_id, change_id)
    end
    sender.update_column(:id, change_id)
    sender.update_column(:sender_out, true)
    session[:sender_id] = nil
    redirect_to senders_path
  end

  private
    def post_params
      params.require(:sender).permit(:name)
    end

    def check_if_sender_has_a_session
      if session[:sender_id]
        user = Sender.find(session[:sender_id]).users.first
        redirect_to sender_path(session[:sender_id], user_id: user.id)
      end
    end
    def what_service_to_send_a_message
      current_user.service_users.each do |service_user|
        service_user.time_service.each do |time_service|
          if Time.now.wday == time_service.week_day
            from = Time.strptime(time_service.from, '%H:%M')
            till = Time.strptime(time_service.till, '%H:%M')
            if Time.now > from && Time.now < till

            end
          end
        end
      end
    end
end




