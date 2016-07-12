require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  
  def setup
    @post = microposts(:orange)
  end

  test "Should redirect create when not logged in" do
    assert_no_difference  'Micropost.count' do
      post :create, micropost: {content: 'exmaple message'}
    end
    assert_redirected_to login_url
  end

  test "Should redirect destroy when not logged in" do
    assert_no_difference  'Micropost.count' do
      delete :destroy, id: @post
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as(users(:elodie))
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: microposts(:tonton)
    end 
  end
end
