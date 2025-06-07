class ChatRoom < ApplicationRecord
  belongs_to :blog
  has_many   :messages, dependent: :destroy
end
