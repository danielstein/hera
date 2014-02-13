
class InspectionsController < ApplicationController
	before_filter :authenticate_user!

	def show
		@inspection = Inspection.find(params[:id]);
		@answers = Answer.where(inspection_id: params[:id])
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
  
  def new
    @inspection = Inspection.new
    @equipments = Equipment.all.collect{|p| [p.name,p.id]}
    @equipment = 0
  end
  
  def create
    inspection = Inspection.new
    inspection.update_attributes(inspection_params)
    inspection.save
    redirect_to inspection_edit_path
  end
  
  def edit
    @inspection = Inspection.find(params[:id])
  end
  
  def update
    
  end

	def index
		@equip_types = EquipType.order("kind").all
		@users = User.order("name").where(kind: "estag")
		@buildings = Building.order("name").all

		@inspections = Inspection.where(approved: 0)
		@inspections = @inspections.where("user_id = ?", params[:user_id]) unless params[:user_id].blank?
		@inspections = @inspections.joins(:equipment).where(equipment: {equip_type_id: params[:equip_type_id]}) unless params[:equip_type_id].blank?
		@inspections = @inspections.where("inspections.created_at > ?", params[:data1]) unless params[:data1].blank?
		@inspections = @inspections.where("inspections.created_at < ?", params[:data2]) unless params[:data2].blank?
		@inspections = @inspections.joins(:equipment).where(equipment: {building_id: params[:building_id]}) unless params[:building_id].blank?
		@inspections = @inspections.where(equipment_id: params[:equipment_id]) unless params[:equipment_id].blank?

	end

	def index_history
		@equip_types = EquipType.order("kind").all
		@users = User.order("name").where(kind: "estag")
		@buildings = Building.order("name").all

		@inspections = Inspection.where("approved <> 0")
		@inspections = @inspections.where("user_id = ?", params[:user_id]) unless params[:user_id].blank?
		@inspections = @inspections.joins(:equipment).where(equipment: {equip_type_id: params[:equip_type_id]}) unless params[:equip_type_id].blank?
		@inspections = @inspections.where("inspections.created_at > ?", params[:data1]) unless params[:data1].blank?
		@inspections = @inspections.where("inspections.created_at < ?", params[:data2]) unless params[:data2].blank?
		@inspections = @inspections.joins(:equipment).where(equipment: {building_id: params[:building_id]}) unless params[:building_id].blank?
		@inspections = @inspections.where(approved: params[:approved_id]) unless params[:approved_id].blank?
		@inspections = @inspections.where(equipment_id: params[:equipment_id]) unless params[:equipment_id].blank?
	end
  
  def inspection_params
    params.require(:inspection).permit(:photo_url,:user_id,:equipment_id,:description,:approved)
  end


end
