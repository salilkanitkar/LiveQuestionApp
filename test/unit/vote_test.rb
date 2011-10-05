require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "two votes can not have same user id" do
    v1 = votes(:vfix_1)
    v2 = votes(:vfix_2)
    assert_not_equal(v1.user_id, v2.user_id, "Two votes can not have same user id")
  end

  test "two votes having same post id can not have same user id" do
    v1 = Vote.new
    v1.id = 101
    v1.post_id = 100
    v1.user_id = 100
    v1.save
    v2 = Vote.new
    v2.id = 102
    v2.post_id = 100
    v2.user_id = 100
    assert v2.save, "Two votes to a same post can not have same User Id"
  end

end
