require "test_helper"

class ChatRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect show if not logged in" do
    get chat_rooms_show_url
    assert_response :redirect
    assert_redirected_to '/login'
  end
end
