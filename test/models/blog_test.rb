require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  def setup
    @blog = Blog.new(
      titulo: 'Una guía de Resident Evil',
      descripcion: 'Descripción detallada...',
      tipo_publicacion: 'guía',
      estado: 'pendiente'
    )
  end

  test "blog válido con atributos mínimos" do
    assert @blog.valid?
  end

  test "titulo debe estar presente" do
    @blog.titulo = nil
    refute @blog.valid?
    assert_includes @blog.errors[:titulo], "can't be blank"
  end

  test "tipo_publicacion inclusion" do
    @blog.tipo_publicacion = 'otro'
    refute @blog.valid?
    assert_includes @blog.errors[:tipo_publicacion], "is not included in the list"
  end

  test "has_many solicitudes_edicion" do
    assert_respond_to @blog, :solicitudes_edicion
  end
end
