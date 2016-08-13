class TimeServicesController < ApplicationController
  def index
    @user_services = current_user.service_users
  end
  def new
    @service_user_id = params[:service_user]
    @time_service = TimeService.new
  end
  def create
    TimeService.create(post_params)
    redirect_to time_services_url
  end
  def edit
    @time_service = TimeService.find_by(id: params[:id])
  end
  def update
    @time_service = TimeService.find_by(id: params[:id])
    @time_service.update(week_day: params.require(:time_service).permit(:week_day)[:week_day], service_user_id: params.require(:time_service).permit(:service_user_id)[:service_user_id], from: params.require(:time_service).permit(:from)[:from], till: params.require(:time_service).permit(:till)[:till])
    redirect_to time_services_path
  end
  def destroy
    TimeService.find_by(id: params[:id]).destroy
    redirect_to time_services_url
  end

  private
    def post_params
     time_params = params.require(:time_service)
     from = Time.new(time_params["from(1i)"].to_i, time_params["from(2i)"].to_i, time_params["from(3i)"].to_i, time_params["from(4i)"].to_i, time_params["from(5i)"].to_i)
     till = Time.new(time_params["till(1i)"].to_i, time_params["till(2i)"].to_i, time_params["till(3i)"].to_i, time_params["till(4i)"].to_i, time_params["till(5i)"].to_i)
     return {week_day: time_params["week_day"], service_user_id: time_params["service_user_id"], from: from, till: till}
    end
end
