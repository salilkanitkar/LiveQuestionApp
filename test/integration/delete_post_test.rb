require 'test_helper'

class DeletePostTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do
    visit("/askuery")
    if(page.has_content?("Sign Out"))
      click_link("Sign Out")
    end
  end

  test "delete a post" do
    fill_in("session_username", :with => "sskanitk")
    fill_in("session_password", :with => "123456")
    click_button("session-sign-in")
    click_link("Ask Question")
    fill_in("question",:with => "test question text")
    click_button("Click here to Post")
    click_link("test question text")
    click_button("Delete")
  end

end
