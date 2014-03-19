class BuildingsController < ApplicationController
  def index
    @blds = Building.all.order(:name)
  end
  
  def new
    @bld = Building.new
  end
  
  def show
  end
  
  def create
    bld = Building.new
    bld.update_attributes(building_params)
    bld.save
    redirect_to buildings_path
  end
  
  def edit
    @bld = Building.find_or_create_by_id(params[:id])
  end
  
  def update
    bld = Building.find params[:id]
    bld.update_attributes(building_params)
    bld.save
    redirect_to buildings_path
  end
  
  def building_params
    params.require(:building).permit(:name,:idAtlas)
  end
end
