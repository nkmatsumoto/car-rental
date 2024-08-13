class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
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
    # code the part
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :car_id)
  end
end
