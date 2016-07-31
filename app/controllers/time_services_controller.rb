class TimeServicesController < ApplicationController
  def index
    @services_of_user = current_user.service_users
  end
  def new
    @service_user_id = params[:service_user]
    @time_service = TimeService.new
  end
  def create
    TimeService.create(week_day: params.require(:time_service).permit(:week_day)[:week_day], service_user_id: params.require(:time_service).permit(:service_user_id)[:service_user_id], from: params.require(:time_service).permit(:from)[:from], till: params.require(:time_service).permit(:till)[:till])
    redirect_to time_services_url
  end
  def edit
    @time_service = TimeService.find(params[:id])
    @service_user_id = @time_service.service_user_id
  end
  def update
    @time_service = TimeService.find(params[:id])
    @time_service.update(week_day: params.require(:time_service).permit(:week_day)[:week_day], service_user_id: params.require(:time_service).permit(:service_user_id)[:service_user_id], from: params.require(:time_service).permit(:from)[:from], till: params.require(:time_service).permit(:till)[:till])
    redirect_to time_services_path
  end
  def destroy
    TimeService.find(params[:id]).destroy
    redirect_to time_services_url, notice: 'Product was successfully destroyed.'
  end

end
