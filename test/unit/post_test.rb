require 'test_helper'

class PostTest < ActiveSupport::TestCase

  fixtures :posts

  test "the truth" do
    assert true
  end

  test "question should be present" do
    post = Post.new
    assert !post.save
  end

  test "post should have a unique user id" do
    post = posts(:pfix_1)
    assert_equal(post.user_id, 1)
  end

end
