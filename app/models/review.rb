class Review < ApplicationRecord
  self.primary_key = 'id_reseña'

  belongs_to :blog, foreign_key: 'id_blog'
  belongs_to :user, foreign_key: 'id_usuario'

  validates :calificacion, presence: true, inclusion: { in: 1..5 }
  validates :descripcion, presence: true
end