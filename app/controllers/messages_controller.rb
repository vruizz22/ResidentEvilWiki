class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @blog      = Blog.find(params[:blog_id])
    @chat_room = @blog.chat_room
    @message   = @chat_room.messages.build(
                  user:    current_user,
                  content: message_params[:content]
                )

    if @message.save
      # render_to_string corre en el contexto de esta petición, con Warden
      html = render_to_string(
        partial: "messages/message",
        locals:  { message: @message }
      )
      ActionCable.server.broadcast(
        "chat_room_#{@chat_room.id}",
        { message: html }
      )
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to blog_chat_room_path(@blog) } # fallback
      end
    else
      head :unprocessable_entity
    end
  end

  private

  # ← Este método faltaba
  def message_params
    params.require(:message).permit(:content)
  end

end
