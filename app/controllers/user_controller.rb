class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @inspections = Inspection.all
    @equipTypes = EquipType.all
    @users = User.all
    @users = @users.where("name like ?", "%#{params[:search]}%") unless params[:search].blank?
    @users = @users.where("kind = ?", params[:user_type]) unless params[:user_type].blank?
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find params[:id]
    @roles = [["Administrador/Aprovador","admin"],["Normal","normal"]]
    @role = @user.kind
    
    if (@role.nil?) 
      @role = "normal"
    end
  end
  
  def update
    user = User.find params[:id]
    user.update_attributes(userdata_params)
    user.save
    redirect_to user_path(params[:id])
  end
  
  def userdata_params
    params.require(:user).permit(:name,:nusp,:cpf,:kind)
  end
  
end
