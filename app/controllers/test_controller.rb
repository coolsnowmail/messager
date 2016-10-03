class TestController < ApplicationController
  def connect_test
    service = Service.find_by(name: "Test")
    user_auth_date = current_user.service_users.new(auth_date: 1111, service_id: service.id)
    user_auth_date.save
    redirect_to user_path(current_user.id)
  end

  def disconnect_test
    service = current_user.services.find_by(name: "Test")
    ServiceUser.find_by(user_id: current_user.id, service_id: service.id).destroy
    redirect_to user_path(current_user.id)
  end
end
