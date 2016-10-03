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
    @service_user_id = @time_service.service_user_id
  end

  def update
    @time_service = TimeService.find_by(id: params[:id])
    @time_service.update(update_params)
    redirect_to time_services_path
  end

  def destroy
    TimeService.find_by(id: params[:id]).destroy
    redirect_to time_services_url
  end

  private
    def post_params
      params.require(:time_service).permit(:week_day, :service_user_id, :from, :till)
    end

   def update_params
    params.require(:time_service).permit(:week_day, :service_user_id, :from, :till)
   end
end
