class GroupsController < ApplicationController
  
  def index
    @groups = Group.all
  end
  
  def show
    @group = Group.find(params[:id])
    @inspections = Inspection.where('group_id = ' + params[:id]).order("created_at DESC")
  end
  
  def new
    @group = Group.new
  end
  
  def create
    group = Group.new
    group.update_attributes(group_params)
    group.save
    redirect_to groups_path
  end
  
  def edit
    @group = Group.find_or_create_by_id(params[:id])
  end
  
  def update
    group = Group.find params[:id]
    group.update_attributes(group_params)
    group.save
    redirect_to groups_path
  end
  
  def group_params
    params.require(:group).permit(:name)
  end
end
