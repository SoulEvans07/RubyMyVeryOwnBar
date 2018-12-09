require 'test_helper'

class CreateAndShareTest < ActionDispatch::IntegrationTest
  def setup
    @test_user = users(:test_user)
    @other_user = users(:other_user)
  end

  test "create and share cocktail" do
    # get login page
    get welcome_url
    assert_response :success

    # post login data
    post login_url, params: {username: @test_user.name, password: 'hidden'}, headers: {'HTTP_REFERER': login_url}
    assert_response :redirect
    follow_redirect!
    assert_not_nil session[:user]
    assert_select "a.list-group-item", @test_user.cocktails.count + 1

    # create new cocktail
    post cocktails_url, params: {cocktail: {name: "new cocktail", description: "empty descr", recipe: "no recipe"}}, headers: {'HTTP_REFERER': new_cocktail_url}
    assert_response :redirect
    follow_redirect!
    assert_select "a.list-group-item", @test_user.cocktails.count + 1

    # check other user cocktails
    assert_equal @other_user.cocktails.count, 0

    # share cocktail with other_user
    ct = @test_user.cocktails.order(:created_at).last
    post share_cocktail_path(ct.id), params: {id: ct.id, username_to: @other_user.name}, headers: {'HTTP_REFERER': share_cocktail_path(ct.id)}

    # validate share
    assert_equal @other_user.cocktails.count, 1
    assert_equal @other_user.cocktails.order(:created_at).last.name, "new cocktail"

    # logout
    get logout_url
    assert_response :redirect
    assert_nil session[:user]
  end
end
