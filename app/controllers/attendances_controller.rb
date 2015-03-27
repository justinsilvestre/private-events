class AttendancesController < ApplicationController

	before_action :logged_in?, only: [:create, :destroy]


	def create
		@event = Event.find(params[:id])
		@attendance = @event.attendances.create(attendee_id: current_user.id)
		respond_to do |format|
			format.html {	redirect_to @event }
			format.js
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@attendance = current_user.attendances.find_by(attended_event_id: params[:id])
		unless current_user.attending? @event
				flash[:danger] = 'You may only perform this action on events you created yourself.'
				redirect_to @event
		end
		@attendance.delete
		respond_to do |format|
			format.html {	redirect_to events_url }
			format.js
		end
	end

	private

		def logged_in?
			unless current_user
				flash[:danger] = 'You must be logged in to do that.'
				store_location
				redirect_to login_url
			end
		end

end
