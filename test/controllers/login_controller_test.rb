require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get welcome_url
    assert_response :success
    assert_select "input[type=submit][value=Login]"
  end
end
