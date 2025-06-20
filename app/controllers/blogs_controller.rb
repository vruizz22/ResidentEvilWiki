class BlogsController < ApplicationController
  before_action :authenticate_user!, only: [
    :create, :mis_blogs, :editar_rechazado, :reenviar_moderacion, :moderar, :actualizar_estado
  ]
  before_action :require_moderador!, only: [:moderar, :actualizar_estado]

  def index
    @blogs = Blog.where(estado: 'aprobado').order(created_at: :desc)
  end

  def show
    @blog = Blog.find(params[:id])
    @reviews = @blog.reviews.order(created_at: :desc)
    @review = Review.new

    # Integración RAWG: solo si hay game_name
    if @blog.game_name.present?
      require Rails.root.join('app/services/rawg_api_service')
      api_key = Rails.application.credentials.rawg_api_key || ENV['RAWG_API_KEY']
      if api_key.present?
        cache_key = "rawg_game_#{@blog.game_name.parameterize}" # clave única por nombre de juego
        @rawg_game = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
          Rails.logger.info "Consultando la API de RAWG para: #{@blog.game_name}"
          rawg_service = RawgApiService.new(api_key)
          rawg_service.search_game(@blog.game_name)
        end
      else
        @rawg_game = nil
      end
    else
      @rawg_game = nil
    end
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.estado = 'pendiente'
    @blog.id_autor = current_user.id

    if @blog.save
      respond_to do |format|
        format.html { redirect_to blog_path(@blog), notice: "Blog creado con éxito. Pendiente de aprobación." }
        format.json { render json: @blog, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @blog.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy if current_user&.admin?
    redirect_to blogs_path, notice: "Blog eliminado correctamente."
  end

  # ✅ Moderación por parte de administradores
  def moderar
    @blogs_pendientes = Blog.where(estado: 'pendiente')
  end

  def actualizar_estado
    @blog = Blog.find(params[:id])

    if params[:estado] == 'aprobado'
      @blog.update(estado: 'aprobado', mensaje_moderacion: nil)
      redirect_to blogs_moderar_path, notice: "Blog aprobado correctamente"
    elsif params[:estado] == 'rechazado'
      @blog.update(
        estado: 'rechazado',
        mensaje_moderacion: params[:mensaje_moderacion]
      )
      redirect_to blogs_moderar_path, notice: "Blog rechazado con mensaje"
    else
      redirect_to blogs_moderar_path, alert: "Estado no válido"
    end
  end

  # Vista para autores: "Mis Blogs"
  def mis_blogs
    @mis_blogs = Blog.where(id_autor: current_user.id).order(created_at: :desc)
  end

  # Edición especial de blogs rechazados
  def editar_rechazado
    @blog = Blog.find(params[:id])
    unless @blog.id_autor == current_user.id && @blog.estado == "rechazado"
      redirect_to root_path, alert: "No autorizado"
    end
  end

  # Reenvío a moderación después de editar
  def reenviar_moderacion
    @blog = Blog.find(params[:id])
    if @blog.id_autor == current_user.id && @blog.estado == "rechazado"
      if @blog.update(blog_params.merge(estado: "pendiente", mensaje_moderacion: nil))
        redirect_to mis_blogs_path, notice: "Blog reenviado a moderación."
      else
        render :editar_rechazado
      end
    else
      redirect_to root_path, alert: "No autorizado"
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:titulo, :descripcion, :tipo_publicacion, :etiquetas, :attachment, :game_name)
  end

  def require_moderador!
    unless current_user&.admin?
      redirect_to root_path, alert: "No tienes permisos para acceder a esta sección."
    end
  end
end
