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

    puts "PARAMS recibidos: #{params.inspect}"
    puts "Solicitud válida?: #{@solicitud.valid?}"
    puts "Errores: #{@solicitud.errors.full_messages}"

    if @solicitud.save
      puts "✔️ Solicitud guardada"
      redirect_to blogs_path, notice: "Tu nueva versión fue enviada para revisión."
    else
      puts "❌ Falló al guardar"
      render :new
    end
  end


  def index
    @solicitudes = SolicitudEdicion.where(estado: "pendiente")
  end

  def update
    @solicitud = SolicitudEdicion.find(params[:id])
    @solicitud.update(estado: params[:estado])
    redirect_to solicitud_edicion_index_path, notice: "Solicitud actualizada"
  end

  private

  def solicitud_params
    params.require(:solicitud_edicion).permit(:titulo, :descripcion, :tipo_publicacion, :etiquetas, :blog_id)
  end

  def require_moderador!
    redirect_to root_path, alert: "No autorizado" unless current_user&.admin?
  end
end
