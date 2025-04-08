class UserReservationsController < ApplicationController
    before_action :set_user_reservation, only: %i[ show edit update destroy ]

  def index
    @user_reservations = UserReservations.where(user_id: current_user.id).all
  end

  def show
  end

  def new
    @user_reservation = UserReservations.new
  end

  def edit
  end

  def create
    raise "Room is busy" if busy?
    
    @user_reservation = UserReservations.new(user_reservation_params)

    respond_to do |format|
      if @user_reservation.save
        format.html { redirect_to @user_reservation, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    raise "Room is busy" if busy?

    respond_to do |format|
      if @room.update(user_reservation_params)
        format.html { redirect_to @room, notice: "UserReservations was successfully updated." }
        format.json { render :show, status: :ok, location: @user_reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @user_reservation.destroy!

    respond_to do |format|
      format.html { redirect_to user_reservations, status: :see_other, notice: "UserReservations was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_reservation
      @user_reservation = UserReservations.where(user_id: current_user.id).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_reservation_params
      params.require(:user_reservation).permit(:user_id, :room_id, :start, :finish)
    end

    def busy?
        UserReservations.busy?(
            user_reservation_params[:start], 
            user_reservation_params[:finish], 
            user_reservation_params[:room_id]
        )
    end
end
