require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user      = User.create!(email: 'u@e.com', password: '123456')
    @moderador = User.create!(email: 'm@e.com', password: '123456', admin: true)
    @blog      = Blog.create!(
      titulo: 'xxxxxxxxxx',
      descripcion: 'aaa',
      tipo_publicacion: 'noticia',
      estado: 'pendiente',
      id_autor: @user.id
    )
  end

  test "index muestra lista de blogs para usuario no autenticado" do
    # Creamos dos blogs con distinto created_at
    b1 = Blog.create!(titulo: 'título uno', descripcion: 'x', tipo_publicacion: 'noticia', estado: 'aprobado', 
                      created_at: 2.days.ago)
    b2 = Blog.create!(titulo: 'título dos', descripcion: 'y', tipo_publicacion: 'reseña', estado: 'aprobado', 
                      created_at: 1.day.ago)

    get blogs_url
    assert_response :success
    # El último creado debe ir primero
    assert_select 'div.column.is-one-third:first-of-type .card-header-title', text: b2.titulo
    assert_select 'div.column.is-one-third:last-of-type .card-header-title', text: b1.titulo
  end

  test "index asigna sólo blogs aprobados" do
    approved = Blog.create!(
      titulo: 'yyyyyyyyyy',
      descripcion: 'bbb',
      tipo_publicacion: 'reseña',
      estado: 'aprobado'
    )
    get blogs_url
    assert_response :success
    assert_includes assigns(:blogs), approved
    refute_includes assigns(:blogs), @blog
  end

  test "show carga el blog correcto" do
    get blog_url(@blog)
    assert_response :success
    assert_select 'h1', text: @blog.titulo
  end

  test "create redirige al show cuando es válido" do
    sign_in @user
    post blogs_url, params: {
      blog: {
        titulo: 'ABCDEFGHIJ',
        descripcion: 'Una descripción válida',
        tipo_publicacion: 'opinión',
        etiquetas: ''
      }
    }
    assert_redirected_to blog_path(Blog.last)
    assert_equal 'pendiente', Blog.last.estado
    assert_equal @user.id, Blog.last.id_autor
  end

  test "create renderiza new si hay errores" do
    sign_in @user
    post blogs_url, params: { blog: { titulo: '', descripcion: '', tipo_publicacion: 'x' } }
    assert_response :unprocessable_entity
    assert_template :new
  end

  test "moderar_blog como moderador aprueba blog" do
    sign_in @moderador
    patch moderar_blog_url(@blog), params: { estado: 'aprobado' }
    assert_redirected_to blogs_moderar_path
    assert_equal 'aprobado', @blog.reload.estado
  end

  test "moderar_blog rechaza con mensaje" do
    sign_in @moderador
    patch moderar_blog_url(@blog), params: {
      estado: 'rechazado',
      mensaje_moderacion: 'No cumple requisitos'
    }
    assert_redirected_to blogs_moderar_path
    b = @blog.reload
    assert_equal 'rechazado', b.estado
    assert_equal 'No cumple requisitos', b.mensaje_moderacion
  end

  test "moderar_blog con estado inválido muestra alerta" do
    sign_in @moderador
    patch moderar_blog_url(@blog), params: { estado: 'otro' }
    assert_redirected_to blogs_moderar_path
    follow_redirect!
    assert_match /Estado no válido/, flash[:alert]
  end
end
