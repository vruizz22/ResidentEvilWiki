class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Imagen de perfil
  has_one_attached :imagen_perfil

  # Relación como autor de blogs
  has_many :blogs_creados, class_name: 'Blog', foreign_key: 'id_autor'

  # Relación con solicitudes de edición
  has_many :solicitudes_edicion, foreign_key: 'usuario_id'

  # Verificación de rol de moderador
  def es_moderador?
    self.admin == true
  end
end

