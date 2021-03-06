class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :cancel, :confirm, :rebook, :decline]
  before_action :find_user

  def index
    @bookings = Booking.all

    @bookings.each do |b|
      if b.end_date + 1 < Time.now
        b.status = "Completed"
        b.save!
      end

    end
  end

  def new
    @booking = Booking.new
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @booking.pokemon = Pokemon.find(params[:pokemon_id])
    @booking.status = "Pending"
    if @booking.save!
      redirect_to booking_path(@booking)
    else
      render :new
    end
   end

  def show; end

  def edit; end

  def cancel
    @booking.status = "Cancelled"
    @booking.save!

    redirect_to bookings_path
  end

  def confirm
    @booking.status = "Confirmed"
    @booking.save!

    redirect_to pokemon_path(@booking.pokemon)
  end

  def rebook
    @booking.status = "Pending"
    @booking.save!

    redirect_to bookings_path
  end

  def update
    @booking.update(booking_params)

    redirect_to bookings_path
  end

  def decline
    @booking.status = "Decline"
    @booking.save!

    redirect_to pokemon_path(@booking.pokemon)
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
