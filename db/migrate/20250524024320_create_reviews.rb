class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews, primary_key: :id_reseña do |t|
      t.integer :id_blog, null: false
      t.float :calificacion, null: false
      t.text :descripcion, null: false
      t.integer :id_usuario, null: false

      t.timestamps
    end

    add_foreign_key :reviews, :blogs, column: :id_blog
    add_foreign_key :reviews, :users, column: :id_usuario
    add_index :reviews, :id_blog
    add_index :reviews, :id_usuario
  end
end