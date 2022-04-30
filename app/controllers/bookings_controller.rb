class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update]
  before_action :find_user

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @booking.pokemon = @pokemon
    @booking.status = "requested"
    if @booking.save!
      redirect_to booking_path(@booking)
    else
      render :new
    end
   end

  def show; end

  def edit; end

  def update
    @booking.update(booking_params)

    redirect_to booking_path(@booking)
  end

  private

  def find_user
    @user = current_user
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end
end
