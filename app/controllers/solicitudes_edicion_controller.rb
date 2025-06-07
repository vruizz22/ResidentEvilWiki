class SolicitudesEdicionController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :require_moderador!, only: [:index, :update]

  def new
    @blog = Blog.find(params[:blog_id])
    @solicitud = SolicitudEdicion.new(
      blog_id: @blog.id,
      titulo: @blog.titulo,
      descripcion: @blog.descripcion,
      tipo_publicacion: @blog.tipo_publicacion,
      etiquetas: @blog.etiquetas
    )
  end

  def create
    @solicitud = SolicitudEdicion.new(solicitud_params)
    @solicitud.usuario = current_user
    @solicitud.estado = "pendiente"

    if @solicitud.save
      redirect_to blogs_path, notice: "Tu nueva versión fue enviada para revisión."
    else
      @blog = Blog.find(@solicitud.blog_id)
      render :new
    end
  end


  def index
    @solicitudes = SolicitudEdicion.where(estado: "pendiente")
  end

  def update
    @solicitud = SolicitudEdicion.find(params[:id])
    nuevo_estado = params[:estado] || params[:solicitud_edicion][:estado]

    if nuevo_estado == "aceptado"
      blog = @solicitud.blog
      blog.update(
        titulo: @solicitud.titulo,
        descripcion: @solicitud.descripcion,
        tipo_publicacion: @solicitud.tipo_publicacion,
        etiquetas: @solicitud.etiquetas,
        game_name: @solicitud.game_name
      )
      # Copiar adjunto si existe
      if @solicitud.attachment.attached?
        blog.attachment.attach(@solicitud.attachment.blob)
      end
    end

    if @solicitud.update(estado: nuevo_estado)
      redirect_to solicitud_edicion_index_path, notice: "Solicitud actualizada"
    else
      redirect_to solicitud_edicion_index_path, alert: "No se pudo actualizar"
    end
  end



  private

  def solicitud_params
    params.require(:solicitud_edicion).permit(:titulo, :descripcion, :tipo_publicacion, :etiquetas, :blog_id, :game_name, :attachment)
  end

  def require_moderador!
    redirect_to root_path, alert: "No autorizado" unless current_user&.admin?
  end
end
