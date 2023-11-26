class ReservationsController < ApplicationController
    before_action :regular_user_logged_in? ,  only: [:create]
    before_action :admin_logged_in? , only: [:update]
    def create
        booking = current_user.reservations.new(reservation_params)
        if booking.save
            render json:{success:true}
        else
            render json: {success:false, msg: booking.errors.full_messages} , status: 422
        end
    end

     # change pending booking to confirmed / rejected 
     def update
        booking  = Reservation.pending.find_by(id:params[:id])
        resource_not_found_response  && return if booking.nil?
        booking.status = params[:status]
        # assign id of admin of changed the status
        booking.admin = current_user
        render json: {success:true} && return if booking.save
        render json: {success:false, msg: booking.errors.full_messages} , status: :unprocessable_entity 
    end

    private 
        def reservation_params
            params.require(:booking).permit(:time, :date)
        end
end