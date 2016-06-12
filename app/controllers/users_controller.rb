class UsersController < ApplicationController
  before_action :authenticate_user! 
  def index
  	@user = User.find(1)
  end
end
