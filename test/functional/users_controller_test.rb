require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:ufix_1)
  end

  test "should get index" do
    get :index
    assert_redirected_to(:controller => 'system', :action => 'index')
  end

  test "should show user" do
    get(:show, :user => {'id' => "1", 'from_list' => "0"})
    assert_redirected_to(:controller => 'system', :action => 'index')
  end

end
