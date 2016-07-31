class ServicesController < ApplicationController
  def callbacks
    @vk = VkontakteApi.authorize(code: params[:code])
    @vk_id = @vk.user_id
    redirect_to user_path(current_user, vk_id: @vk_id)
  end

  def disconnect_vk
    user = current_user
    user.service_users.where(service_id: 1).first.time_service.each do |time_service|
      time_service.destroy
    end
    user.service_users.where(service_id: 1).first.destroy
    redirect_to user_path(user.id)
  end
end
