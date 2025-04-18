class RemoveAttributesFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :imagen_perfil, :text
    remove_column :users, :correo, :string
    remove_column :users, :contrasena, :string
  end
end
