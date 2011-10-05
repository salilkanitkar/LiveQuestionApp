require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:pfix_1)
  end

  test "A Post should get displayed" do
    get :show, :id => "11", :from_reply_button => "1"
    assert_redirected_to(:controller => 'system', :action => 'index')
  end

end
