class BlogsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @blogs = Blog.order(created_at: :desc)
    # para cuando tengamos moderadores, todavia no los creamos
    #@blogs = Blog.where(estado: "publicado").order(created_at: :desc)
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.fecha = Date.today
    @blog.estado = 'pendiente'
    #@blog.id_moderador = current_user.id if current_user.es_moderador?

    if @blog.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Blog creado con éxito." }
        format.json { render json: blog, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: blog.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def new
    @blog = Blog.new
  end
  

  private

  def blog_params
    params.require(:blog).permit(:titulo, :descripcion, :tipo_publicacion, :etiquetas)
  end
end
