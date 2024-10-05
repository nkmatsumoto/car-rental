class Owner::BookingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @bookings_owner = current_user.bookings_as_owner
    @bookings_user = current_user.bookings.order(start_date: :desc)
    @cars = current_user.cars
  end

  def create
    @car = Car.new(car_params)
    @car.owner = current_owner

    if @car.save
      redirect_to owner_bookings_path, notice: 'Car was successfully added.'
    else
      render :new
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :car_id)
  end
end
