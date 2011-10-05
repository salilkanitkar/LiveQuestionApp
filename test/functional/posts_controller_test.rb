require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:pfix_1)
  end

  test "A Post should get displayed" do
    get :show, :post_id => "1", :user_id => "1", :caller => "system"
    assert_redirected_to(:controller => 'system', :action => 'index')
  end

end
