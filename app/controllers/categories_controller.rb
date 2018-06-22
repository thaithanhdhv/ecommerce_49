class CategoriesController < ApplicationController
  before_action :load_category, only: %i(index show)

  def index
    @categories = Category.includes(:subcategories)
      .order_name.paginate page: params[:page], per_page: Settings.cate_per_page
  end

  def show; end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:warning] = t ".cate_nil"
    redirect_to root_path
  end
end
