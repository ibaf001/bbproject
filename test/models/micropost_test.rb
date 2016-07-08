require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:miranda)
    #@post = Micropost.new(user_id: @user.id, content: "premier post")
    @post = @user.microposts.build(content: "mbote ba mpangi")
  end

  test "Should be valid" do
    assert @post.valid?
  end

  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
   
  end

  test "content should be present" do
    @post.content = " "
    assert_not @post.valid?
  end

  test "content should not be more than 150 characters" do
    @post.content = "a"*151
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end

  

end
