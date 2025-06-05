class HomeController < ApplicationController
  def index
    @latest_blogs = Blog.where(estado: 'aprobado').order(created_at: :desc).limit(3)
  end
end
