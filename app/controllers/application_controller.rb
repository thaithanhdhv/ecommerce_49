class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_global_search_variable

  include SessionsHelper
  include CartsHelper

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.json{head :forbidden}
      format.html{redirect_to root_path, alert: t("flash_warning_user")}
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    render file: "public/404.html", status: 404, layout: true
  end

  def valid_object object
    render file: "public/404.html", status: 404, layout: true unless object
  end

  def check_valid? id
    redirect_to root_path unless id
  end

  private

  def set_global_search_variable
    @q = Product.search params[:q]
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t("login_required")
    redirect_to login_path
  end

  def is_admin
    return if user_signed_in? && current_user.admin?
    redirect_to root_path
  end

  def current_cart
    @producs_of_current_cart = Product.load_product_by_ids session[:cart].keys
  end

  def quantity_in_cart
    @producs_of_current_cart.each do |item|
      item.quantity_in_cart = session[:cart][item.id.to_s]
    end
  end

  def load_categories
    @categories = Category.all
  end

  def correct_rating_user
    @rating = Rating.find_by id: params[:id]
    unless @rating == (current_user.ratings.find_by id: params[:id])
      redirect_to root_path
    end
  end
end
