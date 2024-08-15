class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings.order(start_date: :desc)
  end

  def create
    @car = Car.find(params[:car_id])
    @booking = Booking.new(booking_params)
    @booking.car = @car
    days = (@booking.end_date - @booking.start_date).to_i
    @booking.total_price = days * @car.rate
    @booking.user = current_user
    if @booking.save

      redirect_to bookings_path, notice: "Booking was successfully created"
    else

      # show the form again but with the @restaurant in this method
      render 'cars/show', status: :unprocessable_entity
    end
  end


  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      # redirect_to # up to you...
      redirect_to owner_bookings_path, notice: "Booking was successfully reviewed"
    else
      # render # where was the booking update form?
      render 'owner/bookings', status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :car_id, :status)
  end
end
