class Blog < ApplicationRecord
  has_one_attached :attachment
  has_one :chat_room, dependent: :destroy

  belongs_to :moderador, class_name: 'User', foreign_key: 'id_moderador', optional: true
  belongs_to :autor, class_name: 'User', foreign_key: 'id_autor', optional: true

  validates :titulo, presence: true, length: { in: 10..100 }
  validates :descripcion, presence: true
  validates :tipo_publicacion, inclusion: { in: ['guía', 'reseña', 'opinión', 'noticia'] }
  validates :estado, inclusion: { in: ['pendiente', 'aprobado', 'rechazado'] }
  validates :attachment, 
            content_type: ['image/png', 'image/jpeg', 'image/webp'],
            size: { less_than: 15.megabytes, message: "debe ser menor a 15MB" }
  validates :game_name, length: { maximum: 100 }, allow_nil: true

  has_many :solicitudes_edicion, dependent: :destroy
  has_many :reviews, foreign_key: 'id_blog', dependent: :destroy
end

