class Owner::BookingsController < ApplicationController
  def index
<<<<<<< HEAD
    @bookings_owner = current_user.bookings_as_owner
    @bookings_user = current_user.bookings.order(start_date: :desc)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :car_id)
=======
    # @bookings = Booking.joins(:car).where(cars: { user_id: current_user.id })
>>>>>>> master
  end
end
