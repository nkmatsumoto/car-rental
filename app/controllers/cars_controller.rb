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
    @car = current_user.cars.build(car_params)
    if @car.save
      redirect_to owner_bookings_path, notice: "Car was successfully listed"
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def search
    if params[:query].pesent?
      # sql_query = "brand ILIKE :query OR model ILIKE :query"
      # sql_query = <<~SQL
      #   cars.brand @@ :query
      #   cars.model @@ :query
      #   cars.year @@ :query
      # SQL
      @cars = Car.search_by(params[:query])
    else
      @cars.Car.all
    end
  end

  private

  def car_params
    params.required(:car).permit(:brand, :model, :year, :rate, :description, photos: [])
  end
end
