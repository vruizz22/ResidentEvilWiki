import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  const chat = document.getElementById("chat-room")
  if (!chat) return

  const roomId = chat.dataset.chatRoomId

  consumer.subscriptions.create(
    { channel: "ChatRoomChannel", chat_room_id: roomId },
    {
      connected() {
        // Opcional: ejecutar algo cuando se conecte
      },

      disconnected() {
        // Opcional: limpiar cuando se desconecte
      },

      received(data) {
        // Insertar el HTML del mensaje recibido
        const messagesContainer = chat.querySelector(".messages")
        messagesContainer.insertAdjacentHTML("beforeend", data.message)
        messagesContainer.scrollTop = messagesContainer.scrollHeight
      }
    }
  )
})
