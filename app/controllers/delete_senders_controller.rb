class DeleteSendersController < ApplicationController
  def senders_delete
    sender = Sender.find(params[:sender_id])
    sender.destroy
    redirect_to user_path(current_user.id)
  end
end
