class Blog < ApplicationRecord
  belongs_to :moderador, class_name: 'Usuario', foreign_key: 'id_moderador', optional: true

  validates :titulo, presence: true, length: { in: 10..100 }
  validates :descripcion, presence: true
  validates :tipo_publicacion, inclusion: { in: ['guía', 'reseña', 'opinión', 'noticia'] }
  validates :estado, inclusion: { in: ['pendiente', 'aprobado', 'rechazado'] }
end

