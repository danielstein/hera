require 'test_helper'

class UserControllerTest < ActionController::TestCase

  def setup
    @users = User.all
  end

  def teardown
    @users = nil
  end

  test "should get index" do
    @users.each do |user|
      get :index, :search => user.name, :user_type => user.kind
      assert_response :success
    end
  end

  test "should get show" do
    @users.each do |user|
      get :show, :id => user.id
      assert_response :success
    end
  end

end
