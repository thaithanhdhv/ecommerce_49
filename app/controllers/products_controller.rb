class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :load_products, only: :filter_product
  after_action :load_comments, :load_ratings, only: :show

  def index
    @products = @q.result.order_price
      .paginate page: params[:page], per_page: Settings.product_per_page
    @categories =  Category.includes(:subcategories).order_name
  end

  def show; end

  def filter_product; end

  private

  def load_products
    case
    when params[:cat_id]
      @products = Product.by_category params[:cat_id]
    when params[:sort_by]
      @products  = Product.order_name params[:sort_by].to_sym
    else params[:price_min][:value] && params[:price_max][:value]
      @products  = Product.min_max_price params[:price_min][:value], params[:price_max][:value]
    end
  end

  def load_comments
    @comments = @product.comments.includes(:users)
      .paginate page: params[:page], per_page: Settings.paginate.comment_perpage
    @comment = current_user.comments.build if user_signed_in?
  end

  def load_ratings
    @ratings = @product.ratings.includes(:users)
    @rating = current_user.ratings.build if user_signed_in?
  end
end
