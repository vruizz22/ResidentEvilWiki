class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Asociación con Active Storage
  has_one_attached :imagen_perfil

  # Validaciones
  validates :descripcion, length: { maximum: 500 }
  validate :validate_imagen_perfil

  # Método Privado para validar el formato y tamaño de la imagen
  private
  def validate_imagen_perfil
    return unless imagen_perfil.attached?
    
    if imagen_perfil.blob.byte_size > 5.megabytes
      errors.add(:imagen_perfil, "es demasiado grande (máximo 5MB)")
    end
    
    unless imagen_perfil.blob.content_type.in?(%w(image/jpeg image/png))
      errors.add(:imagen_perfil, "debe ser JPG o PNG")
    end
  end
end