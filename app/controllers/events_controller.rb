class EventsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :destroy]

	def index
		@events = Event.all
	end

	def show
		@event = Event.find(params[:id])
	end

  def new
  	@event = current_user.events.build
  end

  def create
    create_params = event_params
    create_params[:date] = ActiveSupport::TimeZone['UTC'].parse(create_params[:date].to_s)
    @event = current_user.events.build(create_params)
  	if @event.save
  		redirect_to @event
  	else
  		render 'new'
  	end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.creator == current_user
      @event.delete
      flash[:success] = "#{@event.name} was successfully deleted."
      redirect_to current_user
    else
      flash[:danger] = "You may only delete events you created."
      redirect_to @event
    end
  end

  private

  	def event_params
  		params.require(:event).permit(:name, :description, :date, :location)
  	end

  	def logged_in_user
  		unless user = current_user
  			store_location
  			redirect_to login_url
  		end
  	end

end
