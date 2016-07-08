require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username: "User_test", email: "mama@gmail.com",password: "johanna", password_confirmation: "johanna")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "x" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "x" * 256
    assert_not @user.valid?
  end


  test "email should be valid address" do
    valid_addresses = %w[user@example.com USER@goo.COM A_US-ER@foo.bar.org first.last@foo.jp mongo+ka@foo.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?
    end

  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com use_at_goo.com user.name@gmail. foo@gat_hsj.com foo@bar+bas.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end

  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end


  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "x" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember,'') 
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "je suis beni")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

end





























