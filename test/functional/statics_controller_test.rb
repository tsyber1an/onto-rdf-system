require 'test_helper'

class StaticsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create static" do
    assert_difference('Static.count') do
      post :create, :static => { }
    end

    assert_redirected_to static_path(assigns(:static))
  end

  test "should show static" do
    get :show, :id => statics(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => statics(:one).to_param
    assert_response :success
  end

  test "should update static" do
    put :update, :id => statics(:one).to_param, :static => { }
    assert_redirected_to static_path(assigns(:static))
  end

  test "should destroy static" do
    assert_difference('Static.count', -1) do
      delete :destroy, :id => statics(:one).to_param
    end

    assert_redirected_to statics_path
  end
end
