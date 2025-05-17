class CreateSolicitudesEdicion < ActiveRecord::Migration[7.1]
  def change
    create_table :solicitudes_edicion do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: { to_table: :users }
      t.string :estado, default: "pendiente"

      # Contenido de la nueva versión
      t.string :titulo
      t.text :descripcion
      t.string :tipo_publicacion
      t.string :etiquetas

      t.timestamps
    end
  end
end
