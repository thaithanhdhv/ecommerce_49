class SearchProductsController < ApplicationController
  def index
    @products = Product.starts_with params[:query]
    return if @products
    flash.now[:danger] = t("search_empty")
  end
end
