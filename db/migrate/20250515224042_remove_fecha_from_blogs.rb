class RemoveFechaFromBlogs < ActiveRecord::Migration[7.1]
  def change
    remove_column :blogs, :fecha, :date
  end
end
