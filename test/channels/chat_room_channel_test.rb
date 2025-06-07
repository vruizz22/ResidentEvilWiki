require 'test_helper'

class ChatRoomChannelTest < ActionCable::Channel::TestCase
  def setup
    @user = User.create!(email: 'user2@test.com', password: '123456')
    @blog = Blog.create!(
      titulo: 'Chat funcional test',
      descripcion: 'X',
      tipo_publicacion: 'noticia',
      estado: 'aprobado',
      id_autor: @user.id
    )
    @chat_room = ChatRoom.create!(blog: @blog)
  end


  test "subscribes and streams from correct chat room" do
    stub_connection current_user: @user
    subscribe(chat_room_id: @chat_room.id)
    assert subscription.confirmed?
    assert_has_stream "chat_room_#{@chat_room.id}"
  end
end
