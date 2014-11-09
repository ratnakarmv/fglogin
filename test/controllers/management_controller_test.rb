require 'test_helper'

class ManagementControllerTest < ActionController::TestCase
  test "should get subscription" do
    get :subscription
    assert_response :success
  end

end
