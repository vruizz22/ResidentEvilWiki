class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  def show
    @blog      = Blog.find(params[:blog_id])
    @chat_room = @blog.chat_room || @blog.create_chat_room
    @messages  = @chat_room.messages
                           .includes(:user)
                           .order(created_at: :asc)
  end
end
