class UsersController < ApplicationController
  before_action :authenticate_user! 
  def index
  	@user = current_user
  	redirect_to user_path(current_user)
  end

  def show
  	@user = current_user
  	@message = current_user.messages.build

  end

  def new
    @user_message = current_user.messages.build
    render "index"
  end

  def create
  	@user_message = current_user.messages.build(params[:messages])
  	render "index"
  end
end
