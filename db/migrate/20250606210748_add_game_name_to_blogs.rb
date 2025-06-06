class AddGameNameToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :game_name, :string
  end
end
