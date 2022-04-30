class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update]
  before_action :find_user

  # def create
  #   @booking = Booking.new(booking_params)
  #   @booking.user_id = @user.id
  #   if @booking.save!
  #     redirect_to booking_path(@booking)
  #   else
  #     render :new
  #   end
  # end

  # def edit; end

  # def new
  #   @booking = Booking.new
  # end

  def show
  end

  # def update
  #   @booking.update(booking_params)

  #   redirect_to booking_path(@booking)
  # end

  private

  def find_user
    @user = current_user
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:name, :type, :level,
                                   :location, :rate, :description, :picture)
  end
end
