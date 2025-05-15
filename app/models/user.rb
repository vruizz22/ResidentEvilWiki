class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Asociación con Active Storage
  has_one_attached :imagen_perfil

  # Relación como autor de blogs, blogs_creados para despues diferenciar de blogs_moderados
  has_many :blogs_creados, class_name: 'Blog', foreign_key: 'id_autor'

  def es_moderador?
    self.admin
  end
end
