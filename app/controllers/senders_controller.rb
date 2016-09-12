class SendersController < ApplicationController

  def invite_link
    link = params[:link]
    redirect_to link
  end

  def show
    @sender = Sender.find_by(id: session[:sender_id])
    @user = User.find_by(id: params[:user_id])
    if @sender.messages.empty?
      @message = @sender.messages.build
    else
      @user.services.each do |service|
      auth_date = ServiceUser.find_by(user_id: @user.id, service_id: service.id).auth_date
      eval(service.name).new.receive(auth_date, @user.id)
      end
      @message = @sender.messages.build
    end
  end

  def new
    if session[:sender_id]
      sender = Sender.find_by(id: session[:sender_id])
      user = User.find_by(id: params[:user_id])
      sender.users << user unless sender.users.ids.include?(user.id)
      redirect_to sender_path(session[:sender_id], user_id: user.id)
    end
    @user = User.find_by(id: params[:user_id])
    render :file => '/public/404.html', status => 404, :layout => true if @user == nil
    @sender = Sender.new
  end

  def create
    user = User.find_by(id: params[:user_id])
    @sender = user.senders.build(post_params)
    redirect_to new_sender_path(user_id: user.id), notice: t("enter_ur_name") if @sender.name.blank?
    if user.senders.pluck(:name).include?(@sender.name)
      redirect_to new_sender_path(user_id: user.id), notice: t("notice_that_this_sender_name_have_been_acupate")
    else
      @sender.save if @sender.valid?
      if @sender.persisted?
        session[:sender_id] = @sender.id
        redirect_to sender_path(session[:sender_id], user_id: user.id)
      end
    end
  end

  private
    def post_params
      params.require(:sender).permit(:name)
    end
end
