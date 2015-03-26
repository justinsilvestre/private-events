class AttendancesController < ApplicationController

	before_action :logged_in?, only: [:create, :destroy]


	def create
		@event = Event.find(params[:event_id])
		@attendance = @event.attendances.build(attendee_id: current_user.id)
		@attendance.save
		redirect_to @event
	end

	def destroy
		@event = Event.find(params[:event_id])
		@attendance = Attendance.find(params[:id])
		unless current_user.attending? @event
				flash[:danger] = 'You may only perform this action on events you created yourself.'
				redirect_to @attendance.attended_event
		end
		@attendance.delete
		redirect_to events_path
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
