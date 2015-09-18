class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :set_access_control_headers

  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

    if registered_application.nil?
      render json: "Unregistered application", status: :unprocessable_entity
    else
      # Create a new event associated with the registered_application
      # (the event creation code will need to call the event_params method)
      # We instantiate an event with `build`.
      @event = registered_application.events.build(event_params)
      if @event.save
          render json: @event, status: :created
        else
          render @event.errors, status: :unprocessable_entity
      end
    end
  end


  private

  def event_params
    params.permit(:name)
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Origin, X-Requested-With, X-Prototype-Version, Content-Type'
    headers['Access-Control-Max-Age'] = '1728000'
    render text: "" if request.method == "OPTIONS"
  end


end
