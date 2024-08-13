class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
     redirect_to car_path(@car)
    else
      # show the form again but with the @restaurant in this method
      render 'new', status: :unprocessable_entity
    end

  end

  private

  def car_params
    params.required(:car).permit(:brand, :model, :year, :rate)
  end
end
