class RegisteredApplicationsController < ApplicationController
  def index
    @registered_applications = RegisteredApplication.all
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = RegisteredApplication.new(registered_applications_params)
    @registered_application.user = current_user

    if @registered_application.save
        redirect_to registered_application_path(@registered_application)
        flash[:notice] = "The application has been saved"
    else
        render 'new'
        flash[:error] = "The application could not be saved"
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def registered_applications_params
    params.require(:registered_application).permit(:name, :url)
  end
end
