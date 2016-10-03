class DeleteSendersController < ApplicationController
  def senders_delete
    sender = Sender.find_by(id: params[:sender_id])
    return render :file => '/public/404.html', status => 404, :layout => true unless sender
    flash[:notice] = t("the sender have destried") if sender.destroy
    flash[:notice] = t("the sender is not found") unless sender.destroy
    redirect_to user_path(current_user.id)
  end
end