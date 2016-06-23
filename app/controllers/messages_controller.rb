class MessagesController < ApplicationController

  def create
  	@message =  Message.create(params[:messages])
  	redirect_to sender_path(@message)
  end
    
end
