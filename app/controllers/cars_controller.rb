class CarsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
    lat = @car.user.latitude
    lng = @car.user.longitude
    @markers = [{
      lat: lat,
      lng: lng,
      info_window_html: render_to_string(partial: "info_window", locals: { car: @car }),
      marker_html: render_to_string(partial: "marker")
      }]
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
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
