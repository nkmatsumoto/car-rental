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
    end
  end

  private

  def car_params
    params.required(:car).permit(:brand, :model, :year, :rate)
  end
end
