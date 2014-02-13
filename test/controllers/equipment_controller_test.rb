require 'test_helper'

class EquipmentControllerTest < ActionController::TestCase

  def setup
    @equipments = Equipment.all
  end

  def teardown
    @equipments = nil
  end

  test "should get show" do
    #@equipments.each do |equipment|
    1.times do |n|
      equipment = equipment("equip_#{n}")
      get :show , :id => equipment.id
      assert_response :success
    end
  end

  test "should get validate" do
    @equipments.each do |equipment|
      get :validate , :id => equipment.inspections.last
      assert_response :redirect
    end
  end

  test "should get disapprove" do
    @equipments.each do |equipment|
      get :disapprove , :id => equipment.inspections.last
      assert_response :redirect
    end
  end

  test "should get index" do
    @equipments.each do |equipment|
      get :index , :etype => equipment.equip_type, :building_id => equipment.building.id, :conserved_id => ""
      assert_response :success
    end
  end

end
