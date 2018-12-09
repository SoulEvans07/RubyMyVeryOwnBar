require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @test_user = users(:test_user)
  end

  test "login" do
    get welcome_url
    assert_response :success

    post login_url, params: {username:@test_user.name, password:'hidden'}, headers: {'HTTP_REFERER': login_url}
    assert_response :redirect
    follow_redirect!
    assert_select "a[href='/sessions/destroy']"
    assert_not_nil session[:user]
  end

  test "logout" do
    get welcome_url
    assert_response :success

    post login_url, params: {username:@test_user.name, password:'hidden'}, headers: {'HTTP_REFERER': login_url}
    assert_response :redirect
    assert_not_nil session[:user]

    get logout_url
    assert_response :redirect
    follow_redirect!
    assert_select "input[type=submit][value=Login]"
    assert_nil session[:user]
  end
end
