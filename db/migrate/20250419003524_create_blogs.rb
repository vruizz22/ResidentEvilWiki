class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.string :titulo
      t.text :descripcion
      t.date :fecha
      t.string :tipo_publicacion
      t.string :estado
      t.integer :id_moderador

      t.timestamps
    end
  end
end
