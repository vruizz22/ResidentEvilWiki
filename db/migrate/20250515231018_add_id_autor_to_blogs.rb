class AddIdAutorToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :id_autor, :integer
    add_index :blogs, :id_autor
    add_foreign_key :blogs, :users, column: :id_autor
  end
end
