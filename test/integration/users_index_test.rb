require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @admin = users(:miranda)
    @user = users(:bob)
  end
  
  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index' 
    assert_select 'div.pagination'
    first_page = User.paginate(page: 1)
    first_page.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.username
      unless user == @admin 
        assert_select 'a[href=?]', user_path(user), text: 'delete', method: :delete
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "index as non admin" do
    log_in_as(@user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end






























