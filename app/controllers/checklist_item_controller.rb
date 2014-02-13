class ChecklistItemController < ApplicationController
  before_filter :authenticate_user!
  
  def create

    if(!params[:etype].blank? and !params[:texto_da_pergunta].blank?)
      @checklist_item = ChecklistItem.new;
      @checklist_item.equip_type = EquipType.find(params[:etype])
      @checklist_item.question = params[:texto_da_pergunta]
      @checklist_item.current = true
      @checklist_item.save
    end
    
    redirect_to(checklist_item_index_path)

  end

  def delete

      @checklist_item = ChecklistItem.find(params[:id]);
      @checklist_item.current = false;
      @checklist_item.save;
      redirect_to(checklist_item_index_path)
  end

  def index
      @equip_type_all = EquipType.all;
  		@equip_type = EquipType.all;
      @equip_type = @equip_type.where("kind = ?", params[:etype]) unless params[:etype].blank?
  end
end
