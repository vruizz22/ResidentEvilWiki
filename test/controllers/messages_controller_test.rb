require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect create if not logged in" do
    get messages_create_url
    assert_response :redirect
    assert_redirected_to '/login'
  end
end
