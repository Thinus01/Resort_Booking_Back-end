class BookingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user
      @bookings = current_user.bookings
      render json: @bookings.as_json(include: :resort)
    else
      render json: { message: 'No bookings found for the current user' }, status: :unauthorized
    end
  end

  def show
    booking = Booking.find(params[:id])
    render json: booking, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Booking not found' }, status: :not_found
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      render json: { message: 'booking created', id: @booking.id }, status: :created
    else
      render json: { error: 'Unable to create booking' }, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find_by_id(params[:id])
    if @booking.destroy
      render json: { message: 'Booking removed sucessfully' }, status: :ok
    else
      render json: { message: "Sorry, couldn't remove booking" }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking)
      .permit(:start_date, :end_date, :address, :resort_id)
      .with_defaults(user_id: current_user.id)
  end
end
