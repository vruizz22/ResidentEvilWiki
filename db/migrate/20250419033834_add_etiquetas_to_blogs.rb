class AddEtiquetasToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :etiquetas, :string
  end
end
