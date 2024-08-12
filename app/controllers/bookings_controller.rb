class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    @booking = Bookinge.new()
    if @booking.save
      redirect_to booking_path(@booking)
    else
      # show the form again but with the @restaurant in this method
      render 'new', status: :unprocessable_entity
    end
  end

  def update

  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
