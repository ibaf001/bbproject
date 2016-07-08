require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:miranda)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'

    # Invalid email
    post password_resets_path , password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path , password_reset: { email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url

    #password reset form
    #wrong email
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url

    # Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)

    # Right email wrong token
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url

    # Rigth email and right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    
    # no matching password and confirmation
=begin
    patch password_reset_path(user.reset_token),
             email: user.email,
             user: { password: "montesquieux",
                     password_confirmation: "alibabasf"}
    assert_select "div#error_explanation"
=end

    #blank passwords
    patch password_reset_path(user.reset_token),
             email: user.email,
             user: { password: " ",
                     password_confirmation: " "}
    assert_not flash.empty?
    assert_template 'password_resets/edit'

    patch password_reset_path(user.reset_token),
             email: user.email,
             user: { password: "password",
                     password_confirmation: "password"}
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
    
    
    
    
  end
end
























