class EquipTypesController < ApplicationController
  before_filter :authenticate_user!

def index
   @equiptypelist = EquipType.all
end

def new
  @equiptype = EquipType.new  
end

def create
  equiptype = EquipType.new
  equiptype.update_attributes(equiptype_params)
  equiptype.save
  redirect_to equip_types_path
end

def edit
  @equiptype = EquipType.find params[:id]
end

def update
  equiptype = EquipType.find params[:id]
  equiptype.update_attributes(equiptypefull_params)
  
  equiptype.save
  redirect_to equip_types_path
end
  
def equiptype_params
    params.require(:equip_type).permit(:kind)
end

def equiptypefull_params
    params.require(:equip_type).permit(:kind,checklist_items_attributes:[:id,:question,:_destroy])
end

end