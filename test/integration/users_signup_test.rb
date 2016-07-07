require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information " do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {username: "", email: "moka@d", password: "mata", password_confirmation: "orly"}
    end
    assert_template 'users/new'
    
  end


  test "valid signup information " do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: {username: "mateo23", email: "mat23@gmail.com", password: "matonge", password_confirmation: "matonge"}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    #Try to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    #Invalid activation token
    get edit_account_activation_path('invalid token')
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: 'foo@email')
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?  
    follow_redirect! 
    assert_template 'users/show'
    assert is_logged_in?
    
  end
 
end
