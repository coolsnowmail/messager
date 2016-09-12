class DeleteSendersController < ApplicationController
  def senders_delete
    sender = Sender.find_by(id: params[:sender_id])
    sender.destroy
    redirect_to user_path(current_user.id)
  end
end