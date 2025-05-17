require "test_helper"

class SolicitudesEdicionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get solicitudes_edicion_new_url
    assert_response :success
  end

  test "should get create" do
    get solicitudes_edicion_create_url
    assert_response :success
  end

  test "should get index" do
    get solicitudes_edicion_index_url
    assert_response :success
  end

  test "should get update" do
    get solicitudes_edicion_update_url
    assert_response :success
  end
end
