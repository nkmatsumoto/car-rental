class Owner::BookingsController < ApplicationController
  def index
    # @bookings = Booking.joins(:car).where(cars: { user_id: current_user.id })
  end
end
