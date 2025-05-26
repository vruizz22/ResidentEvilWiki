class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @review = Review.new(review_params)
    @review.id_usuario = current_user.id

    if @review.save
      redirect_to blog_path(@review.id_blog), notice: "¡Reseña publicada!"
    else
      @blog = Blog.find(@review.id_blog)
      @reviews = @blog.reviews.order(created_at: :desc)
      render 'blogs/show', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:id_blog, :calificacion, :descripcion)
  end
end