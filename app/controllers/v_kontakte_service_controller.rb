class VKontakteServiceController < ApplicationController
  def connect_vkontakteservice
    url_vk = VkontakteApi.authorization_url(scope: [:notify, :offline])
    redirect_to url_vk
  end

  def disconnect_vkontakteservice
    service = current_user.services.find_by(name: "VKontakteService")
    ServiceUser.find_by(user_id: current_user.id, service_id: service.id).destroy
    redirect_to user_path(current_user.id)
  end

  def callbacks
    vk = VkontakteApi.authorize(code: params[:code])
    service = Service.find_by(name: "VKontakteService")
    user_auth_date = current_user.service_users.new(auth_date: vk.user_id, service_id: service.id)
    user_auth_date.save
    redirect_to user_path(current_user.id)
  end
end
