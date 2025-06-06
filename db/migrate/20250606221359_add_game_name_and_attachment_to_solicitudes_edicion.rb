class AddGameNameAndAttachmentToSolicitudesEdicion < ActiveRecord::Migration[7.1]
  def change
    add_column :solicitudes_edicion, :game_name, :string
  end
end