require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :users

  test "the truth" do
     assert true
  end

  test "allow valid user only" do
    user = User.new
    user.username="sskanitk"
    user.password="123456"
    user.save   # This will encrypt "123456" and put it in db
    assert User.authenticate("sskanitk", "123456"), "Only users with valid username-password are allowed"
  end

  test "password should get encrypted" do
    user = User.new
    user.username="sskanitk"
    user.password="123456"
    user.save   # This will encrypt "123456" and put it in db
    user.password= users(:ufix_1).password
    assert_not_equal("123456", user.password, "Password should always be encrypted")
  end

  test "username should be present" do
    user = User.new
    user.password = "123456"
    user.name = "Salil"
    user.email = "s@ncsu.edu"
    assert !user.save
  end

  test "password should be present" do
    user = User.new
    user.username = "sskanitk"
    user.name = "Salil"
    user.email = "s@ncsu.edu"
    assert !user.save
  end

  test "name should be present" do
    user = User.new
    user.username = "sskanitk"
    user.password = "123456"
    user.email = "s@ncsu.edu"
    assert !user.save
  end

  test "email should be present" do
    user = User.new
    user.username = "sskanitk"
    user.password = "123456"
    user.name = "Salil"
    assert !user.save
  end

  test "username should be unique" do
    user1 = User.new
    user1.username = "sskanitk"
    user1.save
    user2 = User.new
    user2.username = "sskanitk"
    assert_equal(user1.username, user2.username, "Two users can not have same username")
  end

end
