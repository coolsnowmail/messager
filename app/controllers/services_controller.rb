class ServicesController < ApplicationController
  def show
    @service = Service.find_by(id: params[:id])
    service_user = ServiceUser.find_by(service_id: @service.id, user_id: current_user.id)
    @auth_date = service_user.auth_date if service_user.present?
  end

  def connect
    @service = Service.find_by(id: params[:id])
    path = "http://localhost:3000/connect_" + @service.name.downcase
    redirect_to path
  end

  def disconnect
    @service = Service.find_by(id: params[:id])
    path = "http://localhost:3000/disconnect_" + @service.name.downcase
    redirect_to path
  end
end
