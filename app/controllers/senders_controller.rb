class SendersController < ApplicationController
  def show
  	@sender = Sender.find(params[:id])
  	@message = @sender.messages.build
  end

  def new
  	@sender = Sender.new  	
  end

  def create
  	@sender = Sender.create(post_params)
  	redirect_to sender_path(@sender)
  end

  private
    
   def post_params
     params.require(:sender).permit(:name )
   end
end
