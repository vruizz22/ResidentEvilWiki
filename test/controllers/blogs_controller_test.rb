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
    assert_select 'div.column.is-one-third:first-of-type h2.title', text: b2.titulo
    assert_select 'div.column.is-one-third:last-of-type h2.title', text: b1.titulo
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

  test "mis_blogs solo muestra los blogs del usuario autenticado" do
    otro_usuario = User.create!(email: 'otro@e.com', password: '123456')
    # Blogs de distintos autores
    propio = Blog.create!(titulo: 'Blog Propio', descripcion: 'desc', tipo_publicacion: 'noticia', estado: 'aprobado', 
                          id_autor: @user.id)
    ajeno = Blog.create!(titulo: 'Blog Ajeno', descripcion: 'desc', tipo_publicacion: 'noticia', estado: 'aprobado', 
                         id_autor: otro_usuario.id)
  
    sign_in @user
    get mis_blogs_url
    assert_response :success
    assert_includes assigns(:mis_blogs), propio
    refute_includes assigns(:mis_blogs), ajeno
  end
  
  test "editar_rechazado permite acceso solo al autor y si el blog está rechazado" do
    # Blog rechazado del usuario
    blog_rechazado = Blog.create!(
      titulo: 'Blog Rechazado',
      descripcion: 'desc',
      tipo_publicacion: 'noticia',
      estado: 'rechazado',
      id_autor: @user.id
    )
  
    # Blog aprobado del usuario
    blog_aprobado = Blog.create!(
      titulo: 'Blog Aprobado',
      descripcion: 'desc',
      tipo_publicacion: 'noticia',
      estado: 'aprobado',
      id_autor: @user.id
    )
  
    # Blog rechazado de otro usuario
    otro_usuario = User.create!(email: 'otro@e.com', password: '123456')
    blog_ajeno = Blog.create!(
      titulo: 'Blog Ajeno',
      descripcion: 'desc',
      tipo_publicacion: 'noticia',
      estado: 'rechazado',
      id_autor: otro_usuario.id
    )
  
    # Caso 1: El autor accede a su blog rechazado
    sign_in @user
    get editar_rechazado_blog_url(blog_rechazado)
    assert_response :success
  
    # Caso 2: El autor intenta editar un blog aprobado (no debe poder)
    get editar_rechazado_blog_url(blog_aprobado)
    assert_redirected_to root_path
    assert_equal "No autorizado", flash[:alert]
  
    # Caso 3: El usuario intenta editar un blog rechazado que no es suyo
    get editar_rechazado_blog_url(blog_ajeno)
    assert_redirected_to root_path
    assert_equal "No autorizado", flash[:alert]
  end

  test "reenviar_moderacion solo permite al autor reenviar blogs rechazados" do
  # Blog rechazado del usuario
  blog_rechazado = Blog.create!(
    titulo: 'Blog Rechazado',
    descripcion: 'desc',
    tipo_publicacion: 'noticia',
    estado: 'rechazado',
    id_autor: @user.id
  )

  # Blog aprobado del usuario
  blog_aprobado = Blog.create!(
    titulo: 'Blog Aprobado',
    descripcion: 'desc',
    tipo_publicacion: 'noticia',
    estado: 'aprobado',
    id_autor: @user.id
  )

  # Blog rechazado de otro usuario
  otro_usuario = User.create!(email: 'otro@e.com', password: '123456')
  blog_ajeno = Blog.create!(
    titulo: 'Blog Ajeno',
    descripcion: 'desc',
    tipo_publicacion: 'noticia',
    estado: 'rechazado',
    id_autor: otro_usuario.id
  )

  # Caso 1: El autor reenvía su blog rechazado
  sign_in @user
  patch reenviar_moderacion_blog_url(blog_rechazado), params: {
    blog: { titulo: 'Nuevo Título', descripcion: 'Editado', tipo_publicacion: 'noticia' }
  }
  assert_redirected_to mis_blogs_path
  assert_equal 'pendiente', blog_rechazado.reload.estado
  assert_nil blog_rechazado.reload.mensaje_moderacion

  # Caso 2: El autor intenta reenviar un blog aprobado (no debe poder)
  patch reenviar_moderacion_blog_url(blog_aprobado), params: {
    blog: { titulo: 'Intento', descripcion: 'No debe', tipo_publicacion: 'noticia' }
  }
  assert_redirected_to root_path
  assert_equal "No autorizado", flash[:alert]

  # Caso 3: El usuario intenta reenviar un blog rechazado que no es suyo
  patch reenviar_moderacion_blog_url(blog_ajeno), params: {
    blog: { titulo: 'Intento', descripcion: 'No debe', tipo_publicacion: 'noticia' }
  }
  assert_redirected_to root_path
  assert_equal "No autorizado", flash[:alert]
end
end
