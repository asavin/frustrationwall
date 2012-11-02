require 'test_helper'

class FrustrationsControllerTest < ActionController::TestCase
  setup do
    @frustration = frustrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frustrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frustration" do
    assert_difference('Frustration.count') do
      post :create, frustration: @frustration.attributes
    end

    assert_redirected_to frustration_path(assigns(:frustration))
  end

  test "should show frustration" do
    get :show, id: @frustration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frustration
    assert_response :success
  end

  test "should update frustration" do
    put :update, id: @frustration, frustration: @frustration.attributes
    assert_redirected_to frustration_path(assigns(:frustration))
  end

  test "should destroy frustration" do
    assert_difference('Frustration.count', -1) do
      delete :destroy, id: @frustration
    end

    assert_redirected_to frustrations_path
  end
end
