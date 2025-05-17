class AddAttachmentToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :attachment, :string
  end
end