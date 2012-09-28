require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get callback" do
    get :callback
    assert_response :success
  end

end
