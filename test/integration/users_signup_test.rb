require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

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
      post_via_redirect users_path, user: {username: "mateo23", email: "mat23@gmail.com", password: "matonge", password_confirmation: "matonge"}
    end
    assert_template 'users/show'
    
  end
 
end
