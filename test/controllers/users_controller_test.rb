require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:miranda)
  end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "Should redirect edit when not logged in" do
    get :edit, id: @user
    assert_redirected_to login_url
  end

  test "Should redirect update when not logged in" do
    patch :update, id: @user, user: {username: @user.username, email: @user.email}
    assert_redirected_to login_url
  end

end
