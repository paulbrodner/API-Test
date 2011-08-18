require 'test_helper'

class FileAssetsControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get tags" do
    get :tags
    assert_response :success
  end

  test "should get tag" do
    get :tag
    assert_response :success
  end

end
