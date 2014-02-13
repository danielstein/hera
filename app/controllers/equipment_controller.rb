class EquipmentController < ApplicationController
  before_filter :authenticate_user!

  def show
      @equipment = Equipment.find params[:id]
      if (@equipment.nil?)
        redirect_to equipment_index_path
      else
        @inspection = @equipment.inspections.last
        if (@inspection.nil?)
          redirect_to equipment_index_path
        else
          @answers = @inspection.answers
        end
      end
  end
  
  def new
    @equipment = Equipment.new
    @predios = Building.all.collect{|p| [p.name,p.id]}
    @predio = 0
    @tipos = EquipType.all.collect{|p| [p.kind,p.id]}
    @tipo = 0
    @simnao = [["Existe",true],["Não Existe",false]]
    @existe = true
  end
  
  def create
    equipment = Equipment.new
    equipment.update_attributes(equipment_params)
    equipment.save
    redirect_to equipment_index_path
  end
  
  def edit
    @equipment = Equipment.find_or_create_by_id(params[:id])
    @predios = Building.all.collect{|p| [p.name,p.id]}
    @predio = @equipment.building.id
    @tipos = EquipType.all.collect{|p| [p.kind,p.id]}
    @tipo = 0
    @simnao = [["Existe",true],["Não Existe",false]]
    @existe = @equipment.is_there
  end
  
  def update
    equipment = Equipment.find params[:id]
    equipment.update_attributes(equipment_params)
    equipment.save
    redirect_to equipment_index_path
  end

  def validate
    @inspection = Inspection.find(params[:id])
    @inspection.update_column :approved, 1
    redirect_to action: :show, id: @inspection.id
  end

  def disapprove
    @inspection = Inspection.find(params[:id])
    @inspection.update_column :approved, 2
    redirect_to action: :show, id: @inspection.id
  end

  def index
    respond_to do |format|
      format.html {
        @inspections = Inspection.all

        @equipments = Equipment.all
        @equipments = @equipments.where("equip_type_id = ?", params[:etype]) unless params[:etype].blank?
        @equipments = @equipments.where(building_id: params[:building_id]) unless params[:building_id].blank?
        @equipments = @equipments.where(%q{equipment.id in (
                      select B.EquipmentID from (
                        select T.EquipmentID, T.is_ok from (
                          select inspections.equipment_id as EquipmentID, answers.is_ok as is_ok from equipment
                          join inspections on equipment.id=inspections.equipment_id
                          join answers on answers.inspection_id=inspections.id
                          join checklist_items on checklist_items.id=answers.checklist_item_id
                          where question like 'O equipamento est% conservado%'
                          order by inspections.id desc) as T
                        group by EquipmentID) as B where B.is_ok = ?)}, params[:conserved_id]) unless params[:conserved_id].blank?


        @equipTypes = EquipType.order("kind").all
        @users = User.all
        @buildings = Building.order("name").all
      }

      format.json {
        if params[:building_id]
          @equipment = Equipment.where(building_id: params[:building_id])
        else
          @equipment = Equipment.all
        end
      }

    end
  end
  
  def equipment_params
    params.require(:equipment).permit(:name,:is_there,:equip_type_id,:building_id,:floor,:id_place)
  end


end
