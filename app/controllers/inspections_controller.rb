
class InspectionsController < ApplicationController
	before_filter :authenticate_user!

	def show
		@inspection = Inspection.find(params[:id]);
		@answers = Answer.where(inspection_id: params[:id])
    prepared_url = @inspection.photo_url.to_s
    prepared_url.slice!(0)    
    @inspection_url = root_url + prepared_url
	end

	def validate
    if (current_user.kind == "admin")
      @inspection = Inspection.find(params[:id])
      @inspection.update_column :approved, 1
      redirect_to action: :show, id: @inspection.id
    else
      redirect_to action: :show, id: @inspection.id
    end
	end

	def disapprove
    if (current_user.kind == "admin")
      @inspection = Inspection.find(params[:id])
      @inspection.update_column :approved, 2
      redirect_to action: :show, id: @inspection.id
    else
      redirect_to action: :show, id: @inspection.id
    end    
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
    redirect_to edit_inspection_path(inspection.id)
  end
  
  def edit
    @inspection = Inspection.find(params[:id])
    @questions = @inspection.equipment.equip_type.checklist_items.collect{|p| [p.id, p.question] }
    @answertypes = [["Sim",0],["Não",1], ["Não se Aplica",2]]
    
    @answer_data = Answer.where(inspection_id: params[:id])
    
    @answer_test = @answer_data.where(checklist_item_id: 29)
    

  end
  
  def update
    inspection = Inspection.find params[:id]
    inspection.group_id = params[:inspection][:group_id]
    inspection.save
    answer_data = params[:answers]
    answer_data.each do |answer|
      answer_db = Answer.where(inspection_id: inspection.id, checklist_item_id: answer[0])
      answer_db_data = answer_db.first #passa de relation para o objeto que precisamos
      
      photo_data = nil
      
      if (!params[:photos].nil?)
        photo_data = params[:photos][answer[0]]
      end
      
      if (answer_db_data.nil?)
        answer_new = Answer.new
        answer_new.inspection_id = inspection.id
        answer_new.checklist_item_id = answer[0]
        answer_new.is_ok = answer[1]
        answer_new.comment = params["comment_" + answer[0].to_s]
        answer_new.save
        
        #upload!
        if (!photo_data.nil?)
          photo_data.each do |photo|
            new_upload = Upload.new
            new_upload.answer_id = answer_new.id
            new_upload.photo = photo
            new_upload.save
          end
        end
      else
        answer_db_data.is_ok = answer[1]
        answer_db_data.comment = params["comment_" + answer[0].to_s]
        answer_db_data.save
        
        #upload!
        if (!photo_data.nil?)
          photo_data.each do |photo|
            new_upload = Upload.new
            new_upload.answer_id = answer_db_data.id
            new_upload.photo = photo
            new_upload.save
          end
        end
      end
    end
    redirect_to inspection_path id: inspection.id
  end

	def index
		@equip_types = EquipType.order("kind").all
		@users = User.order("name").where(kind: "estag")
		@buildings = Building.order("name").all

		@inspections = Inspection.where(approved: 0).order("created_at DESC")
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

		@inspections = Inspection.where("approved <> 0").order("created_at DESC")
		@inspections = @inspections.where("user_id = ?", params[:user_id]) unless params[:user_id].blank?
		@inspections = @inspections.joins(:equipment).where(equipment: {equip_type_id: params[:equip_type_id]}) unless params[:equip_type_id].blank?
		@inspections = @inspections.where("inspections.created_at > ?", params[:data1]) unless params[:data1].blank?
		@inspections = @inspections.where("inspections.created_at < ?", params[:data2]) unless params[:data2].blank?
		@inspections = @inspections.joins(:equipment).where(equipment: {building_id: params[:building_id]}) unless params[:building_id].blank?
		@inspections = @inspections.where(approved: params[:approved_id]) unless params[:approved_id].blank?
		@inspections = @inspections.where(equipment_id: params[:equipment_id]) unless params[:equipment_id].blank?
	end
  
  def inspection_params
    params.require(:inspection).permit(:photo_url,:user_id,:equipment_id,:description,:group_id,:approved)
  end

  def answers_params
    params.require(:inspection).permit(answers_attributes[:is_ok])
  end

end
