require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:miranda)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user) , user: {username: "", email: "foo@invalid" , password: "motomoko", password_confirmation: "hgddfd"}
    assert_template 'users/edit'
  end

  test "successful edit" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
   # assert_template 'users/edit'
    
    patch user_path(@user) , user: {username: "elohim", email: "elohim@gmail.com" , password: "", password_confirmation: ""}
    assert_not flash.empty?    
    assert_redirected_to @user
    @user.reload
    assert_equal @user.username , 'elohim'
    assert_equal @user.email , 'elohim@gmail.com'
  end

end
