class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!

  # GET /reservations
  def index
    @user_reservations = Reservation.where(user_id: current_user.id)

    render json: @user_reservations
  end

  # GET /reservations/1
  def show
    @reservation = Reservation.find(params[:id])
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    render json: { reservation: @reservation, message: "Reservation deleted." }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:start_time, :end_time, :item_id)
    end
end
