class Blog < ApplicationRecord
  has_one_attached :attachment

  belongs_to :moderador, class_name: 'Usuario', foreign_key: 'id_moderador', optional: true
  belongs_to :autor, class_name: 'User', foreign_key: 'id_autor', optional: true

  validates :titulo, presence: true, length: { in: 10..100 }
  validates :descripcion, presence: true
  validates :tipo_publicacion, inclusion: { in: ['guía', 'reseña', 'opinión', 'noticia'] }
  validates :estado, inclusion: { in: ['pendiente', 'aprobado', 'rechazado'] }
  validates :attachment, 
            content_type: ['image/png', 'image/jpeg', 'application/pdf'],
            size: { less_than: 15.megabytes, message: "debe ser menor a 15MB" }
  has_many :solicitudes_edicion
end

