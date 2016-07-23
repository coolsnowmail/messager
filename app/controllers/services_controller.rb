class ServicesController < ApplicationController
  def callbacks
    @vk = VkontakteApi.authorize(code: params[:code])
    @vk_id = @vk.user_id
    redirect_to user_path(current_user, vk_id: @vk_id)
  end

  def disconnect_vk
    user = current_user
    user.update_attributes(vk_user_id: nil)
    redirect_to user_path(user.id)
  end
end

