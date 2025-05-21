class HomeController < ApplicationController
  def index
    @blogs = Blog.order(created_at: :desc)
    puts @blogs.inspect
  end
end
