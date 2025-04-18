"""
Aqui se añaden los atributos a la tabla de usuarios
Usuario: nombre, descripción y teléfono
"""

class AddAtributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nombre, :string
    add_column :users, :descripcion, :text
    # add_column :users, :imagen_perfil, :text # Eliminado porque usaremos ActiveStorage
    add_column :users, :telefono, :string
  end
end
