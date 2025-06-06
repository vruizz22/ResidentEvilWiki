import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const chatRoom = document.getElementById("chat-room-container")
  const messagesBox = document.getElementById("messages-box")
  const textarea = document.getElementById("message_content")
  const form = document.getElementById("new_message_form")

  if (!chatRoom || !messagesBox || !textarea || !form) return

  // Scroll automático al cargar
  messagesBox.scrollTop = messagesBox.scrollHeight

  // Enviar con Enter, salto de línea con Shift+Enter
  textarea.addEventListener("keydown", (event) => {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault()
      form.requestSubmit()
    }
  })

  const roomId = chatRoom.dataset.chatRoomId

  consumer.subscriptions.create(
    { channel: "ChatRoomChannel", chat_room_id: roomId },
    {
      received(data) {
        messagesBox.insertAdjacentHTML("beforeend", data.message)
        messagesBox.scrollTop = messagesBox.scrollHeight
        textarea.value = ""  // Limpia después de enviar
      }
    }
  )
})
