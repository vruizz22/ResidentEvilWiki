require 'test_helper'

class SolicitudesEdicionControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user      = User.create!(email: 'u@e.com', password: '123456')
    @moderador = User.create!(email: 'm@e.com', password: '123456', admin: true)
    @blog      = Blog.create!(
      titulo: 'xxxxxxxxxx',
      descripcion: 'aaa',
      tipo_publicacion: 'noticia',
      estado: 'aprobado'
    )
  end

  test "new asigna solicitud con valores del blog" do
    sign_in @user
    get new_blog_solicitud_edicion_url(@blog)
    assert_response :success
    sol = assigns(:solicitud)
    assert_equal @blog.id, sol.blog_id
    assert_equal @blog.titulo, sol.titulo
  end

  test "create guarda solicitud y redirige cuando datos válidos" do
    sign_in @user
    assert_difference 'SolicitudEdicion.count', 1 do
      post solicitudes_edicion_index_url, params: {
        solicitud_edicion: {
          blog_id: @blog.id,
          titulo: @blog.titulo,
          descripcion: 'Cambio importante',
          tipo_publicacion: @blog.tipo_publicacion,
          etiquetas: @blog.etiquetas
        }
      }
    end
    assert_redirected_to blogs_path
    assert_equal 'pendiente', SolicitudEdicion.last.estado
  end

  test "create renderiza new si falta desc" do
    sign_in @user
    post solicitudes_edicion_index_url, params: {
      solicitud_edicion: { blog_id: @blog.id, titulo: @blog.titulo, descripcion: '', tipo_publicacion: @blog.tipo_publicacion }
    }
    assert_response :success
    assert_template :new
    assert_select 'div.field_with_errors'
  end

  test "index muestra sólo solicitudes pendientes para moderador" do
    pend = SolicitudEdicion.create!(blog: @blog, usuario: @user, descripcion: 'x', estado: 'pendiente')
    acep = SolicitudEdicion.create!(blog: @blog, usuario: @user, descripcion: 'y', estado: 'aceptado')
    sign_in @moderador
    get solicitud_edicion_index_url
    assert_response :success
    assigns(:solicitudes).each { |s| assert_equal 'pendiente', s.estado }
  end

  test "update acepta y actualiza blog" do
    sol = SolicitudEdicion.create!(blog: @blog, usuario: @user, descripcion: 'x', estado: 'pendiente')
    sign_in @moderador
    patch solicitud_edicion_url(sol), params: { estado: 'aceptado' }
    assert_redirected_to solicitud_edicion_index_path
    assert_equal 'aceptado', sol.reload.estado
    assert_equal @blog.titulo, @blog.reload.titulo
  end

  test "update rechaza solicitud sin fallos" do
    sol = SolicitudEdicion.create!(blog: @blog, usuario: @user, descripcion: 'x', estado: 'pendiente')
    sign_in @moderador
    patch solicitud_edicion_url(sol), params: { estado: 'rechazado' }
    assert_redirected_to solicitud_edicion_index_path
    assert_equal 'rechazado', sol.reload.estado
  end
end
