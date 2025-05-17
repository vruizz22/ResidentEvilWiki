class AddMensajeModeracionToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :mensaje_moderacion, :text
  end
end
