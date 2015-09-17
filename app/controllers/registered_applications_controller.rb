class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @registered_applications = RegisteredApplication.where(user_id: current_user.id)
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = RegisteredApplication.new(registered_applications_params)
    @registered_application.user = current_user

    if @registered_application.save
        flash[:notice] = "The application has been saved"
        redirect_to registered_application_path(@registered_application)
    else
        flash[:error] = "The application could not be saved"
        render 'new'
    end
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def update
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.update_attributes(registered_applications_params)
      flash[:notice] = "Application updated"
      redirect_to registered_application_path(@registered_application)
    else
      flash[:error] = "The application was not updated"
      render 'show'
    end
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "Application deleted"
      redirect_to registered_applications_path
    else
      flash[:notice] = "Application was not deleted"
      render 'show'
    end
  end

  private

  def registered_applications_params
    params.require(:registered_application).permit(:name, :url)
  end
end
