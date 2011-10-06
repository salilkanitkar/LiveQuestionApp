require 'test_helper'

class SigninTest < ActionDispatch::IntegrationTest

  fixtures :all

  setup do
    visit("/askuery")
    if(page.has_content?("Sign Out"))
      click_link("Sign Out")
    end
  end
  test "signin as admin" do
    fill_in("session_username", :with => "sskanitk")
    fill_in("session_password", :with => "123456")
    click_button("session-sign-in")
    assert page.has_content?("sskanitk")
  end

  test "signin as non admin user" do
    fill_in("session_username", :with => "mohanish")
    fill_in("session_password", :with => "123456")
    click_button("session-sign-in")
    assert page.has_content?("mohanish")
  end

end
