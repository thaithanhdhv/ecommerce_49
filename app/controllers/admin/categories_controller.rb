module Admin
  class CategoriesController < AdminController
    before_action :check_parent, only: :update
    load_and_authorize_resource param_method: :category_params

    def index
      @categories = Category.includes(:subcategories)
        .order_name.paginate page: params[:page], per_page: Settings.cate_per_page
    end

    def show; end

    def new; end

    def edit; end

    def create
      if @category.save
        flash[:info] = t "sucess_msg"
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def update
      if @category.update_attributes category_params
        flash[:success] = t "sucess_msg"
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = t ".category_deleted_msg"
      else
        flash[:danger] = t ".category_delete_err_msg"
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit :name, :parent_category
    end

    def check_parent
      return unless @category.id == params[:category][:parent_category].to_i
      flash[:danger] = t "error_message"
      redirect_to edit_admin_category_path @category
    end
  end
end
