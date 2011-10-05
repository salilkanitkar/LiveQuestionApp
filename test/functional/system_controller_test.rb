require 'test_helper'

class SystemControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should use correct title" do
    get :index
    assert_response :success
    assert_select 'title', 'AsKuery'
  end

  test "all questions should get posted" do
    get :see_all_questions
    assert :success
  end

  test "New Post should get added" do
    get :add_new_post
    assert_redirected_to(:controller => 'system', :action => 'index')
  end

  test "New reply should get added" do
    @request.env['HTTP_REFERER'] = '/posts/show/1'
    get :add_new_reply, :post => { 'user_id' => "1", "post_id" => "1", 'question' => "Sample Qsn" }
    assert_redirected_to @request.env['HTTP_REFERER']
  end

  test "New vote should get added" do
    get :add_new_vote, :post_id => "1", :user_id => "1", :caller => "system"
    assert_redirected_to(:controller => 'system', :action => 'index')
  end

  test "A user should get deleted" do
      get :delete_user, :user_id => "1", :listing => "0"
      assert_redirected_to(:controller => 'system', :action => 'index')
  end

end
