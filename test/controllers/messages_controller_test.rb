require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(email: 'user@test.com', password: '123456')
    @blog = Blog.create!(
      titulo: 'Chat funcional test',
      descripcion: 'Probando chat',
      tipo_publicacion: 'noticia',
      estado: 'aprobado',
      id_autor: @user.id
    )
    @chat_room = ChatRoom.create!(blog: @blog)
  end

  test "should redirect create if not logged in" do
    post blog_chat_room_messages_path(@blog), params: { message: { content: "Hola!" } }
    assert_redirected_to new_user_session_path
  end

  test "should create message if logged in" do
    sign_in @user
    assert_difference('Message.count', 1) do
      post blog_chat_room_messages_path(@blog), params: { message: { content: "Hola desde test!" } }
    end
    assert_response :success
  end

  test "should not create message with empty content" do
    sign_in @user
    assert_no_difference('Message.count') do
      post blog_chat_room_messages_path(@blog), params: { message: { content: "" } }
    end
    assert_response :unprocessable_entity
  end
end
