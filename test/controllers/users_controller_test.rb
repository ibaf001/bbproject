require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:miranda)
    @user2 = users(:bob)
  end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "Should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "Should redirect update when not logged in" do
    patch :update, id: @user, user: {username: @user.username, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to login_url
  end


  test "Should redirect edit when logged in as wrong user" do
    log_in_as(@user2)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "Should redirect update when logged in as wrong user" do
    log_in_as(@user2)
    patch :update, id: @user, user: {username: @user.username, email: @user.email}
    assert flash.empty?
    assert_redirected_to root_url
  end

end
