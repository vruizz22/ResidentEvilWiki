class ApplicationController < ActionController::Base
  include CloudinaryHelper  # hace disponibles cl_image_tag en las vistas
end
