class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    @drivers = Driver.find_by(id: params[:id])

    if @drivers.nil?
      head :not_found
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to drivers_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def driver_params
    return params.require(:driver).permit(
      :name, :vin)
    
  end


end
