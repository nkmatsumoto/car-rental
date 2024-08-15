class CarsController < ApplicationController
  def index
    if params[:query].present?
      @cars = Car.search_by(params[:query])
    else
      @cars = Car.all
    end
    @cars_for_markers = Car.all
    @markers = @cars_for_markers.map do |car|
      {
        lat: car.user.latitude,
        lng: car.user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { car: car }),
      }
    end
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
    lat = @car.user.latitude
    lng = @car.user.longitude
    @markers = [{ lat: lat, lng: lng }]
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

  private

  def car_params
    params.required(:car).permit(:brand, :model, :year, :rate, :description, photos: [])
  end
end
