require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(email: 'user@example.com', password: '123456')
    @admin = User.create!(email: 'admin@example.com', password: '123456', admin: true)
  end

  test "el botón Crear Blog aparece para visitante, usuario y moderador" do
    # Visitante
    get root_url
    assert_select 'a.button', text: 'Crear Blog'

    # Usuario autenticado
    sign_in @user
    get root_url
    assert_select 'a.button', text: 'Crear Blog'

    # Moderador (admin)
    sign_in @admin
    get root_url
    assert_select 'a.button', text: 'Crear Blog'
  end

  test "el botón Moderar Blogs solo aparece para moderador" do
    # Visitante
    get root_url
    assert_select 'a.button', text: 'Moderar Blogs', count: 0

    # Usuario autenticado
    sign_in @user
    get root_url
    assert_select 'a.button', text: 'Moderar Blogs', count: 0

    # Moderador (admin)
    sign_in @admin
    get root_url
    assert_select 'a.button', text: 'Moderar Blogs'
  end

  test "el botón Solicitudes de Edición solo aparece para moderador" do
    # Visitante
    get root_url
    assert_select 'a.button', text: 'Solicitudes de Edición', count: 0

    # Usuario autenticado
    sign_in @user
    get root_url
    assert_select 'a.button', text: 'Solicitudes de Edición', count: 0

    # Moderador (admin)
    sign_in @admin
    get root_url
    assert_select 'a.button', text: 'Solicitudes de Edición'
  end
end