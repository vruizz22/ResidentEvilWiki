require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: 'user@example.com',
      password: 'password',
      admin: false
    )
  end

  test "valid user is valid" do
    assert @user.valid?
  end

  test "es_moderador? debe ser false para admin: false" do
    refute @user.es_moderador?
  end

  test "es_moderador? debe ser true para admin: true" do
    @user.admin = true
    assert @user.es_moderador?
  end

  test "relación blogs_creados" do
    assert_respond_to @user, :blogs_creados
  end

  test "relación solicitudes_edicion" do
    assert_respond_to @user, :solicitudes_edicion
  end
end
