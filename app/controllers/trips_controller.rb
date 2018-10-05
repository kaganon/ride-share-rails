class TripsController < ApplicationController

  def index
    if params[:passenger_id]
      @user = Passenger.find_by(id: params[:passenger_id])
      @trips = @user.trips
      # do something if trips not found

    elsif params[:driver_id]
      @user = Driver.find_by(id: params[:driver_id])
      @trips = @user.trips
    else
      @trips = Trip.all
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])
  end

  def create
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @driver = Driver.find_by(status: true)
    @trip = @passenger.trips.new()

    @trip.driver = @driver
    @trip.passenger = @passenger
    @trip.date = Date.today
    @trip.rating = nil
    @trip.cost = rand(1000.0..3000.0)

    @driver.update_attribute(:status, false)

    if @trip.save
      redirect_to passenger_trips_path
    else
      # raise an error message
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      head :not_found
    end

    if trip.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def change_status
  end



  private

  def trip_params
    return params.require(:trip).permit(
      :driver_id, :passenger_id, :date, :rating, :cost
    )

  end

end
