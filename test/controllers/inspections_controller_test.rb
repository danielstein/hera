require 'test_helper'

class InspectionsControllerTest < ActionController::TestCase

  def setup
    @inspections = Inspection.all
  end

  def teardown
    @inspections = nil
  end  

  test "should get show" do
    #@inspections do |inspection|
    1.times do |n|
      inspection = inspections("inspecao_#{n}")
      get :show, :id => inspection.id
      assert_response :success
    end
  end

  test "should get validate" do
    @inspections.each do |inspection|
      get :validate, :id => inspection.id
      assert_response :redirect
    end
  end

  test "should get disapprove" do
    @inspections.each do |inspection|
      get :disapprove, :id => inspection.id
      assert_response :redirect
    end
  end

  test "should get index" do
    @inspections.each do |inspection|
      get :index, :user_id => inspection.user.id, :equip_type_id => inspection.equipment.equip_type.id, :data1 => (inspection.created_at - 86400), :data2 => (inspection.created_at + 86400), :building_id => inspection.equipment.building.id, :equipment_id => inspection.equipment.id
      assert_response :success
    end
  end

  test "should get index_history" do
    @inspections.each do |inspection|
      get :index_history, :user_id => inspection.user.id, :equip_type_id => inspection.equipment.equip_type.id, :data1 => (inspection.created_at - 86400), :data2 => (inspection.created_at + 86400), :approved_id => inspection.approved, :equipment_id => inspection.equipment.id
      assert_response :success
    end
  end

end
