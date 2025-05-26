require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "user@example.com", password: "password", nombre: "Usuario")
    @admin = User.create!(email: "admin@example.com", password: "password", nombre: "Admin", admin: true)
    @blog = Blog.create!(
      titulo: "Blog testeo",
      descripcion: "desc",
      tipo_publicacion: "reseña",
      id_autor: @user.id,
      estado: "aprobado"
    )
    @review = Review.create!(id_blog: @blog.id, calificacion: 5, descripcion: "Muy bueno", id_usuario: @user.id)
  end

  test "debe redirigir si no está autenticado al crear review" do
    assert_no_difference('Review.count') do
      post reviews_path, params: { review: { id_blog: @blog.id, calificacion: 5, descripcion: "Test" } }
    end
    assert_redirected_to new_user_session_path
  end

  test "usuario autenticado puede crear review" do
    sign_in_as(@user)
    assert_difference('Review.count', 1) do
      post reviews_path, params: { review: { id_blog: @blog.id, calificacion: 4, descripcion: "Muy bueno" } }
    end
    assert_redirected_to blog_path(@blog)
  end

  test "admin puede eliminar review" do
    sign_in_as(@admin)
    assert_difference('Review.count', -1) do
      delete review_path(@review)
    end
    assert_redirected_to blog_path(@review.id_blog)
  end

  test "usuario normal no puede eliminar review" do
    sign_in_as(@user)
    assert_no_difference('Review.count') do
      delete review_path(@review)
    end
    assert_redirected_to blog_path(@review.id_blog)
  end

  private
  
  # Helper para simular login con Devise en tests de integración
  def sign_in_as(user)
    post user_session_path, params: { user: { email: user.email, password: 'password' } }
  end
end