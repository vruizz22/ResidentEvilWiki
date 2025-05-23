require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(email: 'user@example.com', password: '123456')
  end

  test "index muestra lista de blogs para usuario no autenticado" do
    # Creamos dos blogs con distinto created_at
    b1 = Blog.create!(titulo: 'título uno', descripcion: 'x', tipo_publicacion: 'noticia', estado: 'aprobado', 
                      created_at: 2.days.ago)
    b2 = Blog.create!(titulo: 'título dos', descripcion: 'y', tipo_publicacion: 'reseña', estado: 'aprobado', 
                      created_at: 1.day.ago)

    get root_url
    assert_response :success
    # El último creado debe ir primero
    assert_select 'div.column.is-one-third:first-of-type .card-header-title', text: b2.titulo
    assert_select 'div.column.is-one-third:last-of-type .card-header-title', text: b1.titulo
  end
end
