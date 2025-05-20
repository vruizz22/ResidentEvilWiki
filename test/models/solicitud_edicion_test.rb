require 'test_helper'

class SolicitudEdicionTest < ActiveSupport::TestCase
  def setup
    blog = Blog.create!(titulo: 'abc1234567', descripcion: 'desc', tipo_publicacion: 'noticia', estado: 'pendiente')
    user = User.create!(email: 'u@e.com', password: '123456')
    @sol = SolicitudEdicion.new(
      blog: blog,
      usuario: user,
      descripcion: 'Quiero cambiar esto',
      estado: 'pendiente'
    )
  end

  test "solicitud válida" do
    assert @sol.valid?
  end

  test "descripcion presencia" do
    @sol.descripcion = ''
    refute @sol.valid?
    assert_includes @sol.errors[:descripcion], "can't be blank"
  end

  test "estado inclusion" do
    @sol.estado = 'invalid'
    refute @sol.valid?
    assert_includes @sol.errors[:estado], "is not included in the list"
  end
end
