module Admin
  class ProductsController < AdminController
    load_and_authorize_resource param_method: :product_params

    def index
      @products = Product.includes(:category)
        .order_price.paginate page: params[:page], per_page: Settings.product_per_page
    end

    def show; end

    def new; end

    def edit; end

    def create
      @product = Product.new product_params
      if @product.save
        flash[:info] = t "admin.create_product"
        redirect_to @product
      else
        render :new
      end
    end

    def update
      if @product.update_attributes product_params
        flash[:success] = t "sucess_msg"
        redirect_to admin_products_path
      else
        render :edit
      end
    end

    def destroy
      if @product.destroy
        flash[:success] = t ".product_deleted_msg"
      else
        flash[:danger] = t ".product_delete_err_msg"
      end
      redirect_to admin_products_path
    end

    private

    def product_params
      params.require(:product).permit :name, :price, :description, :quantity, :image, :category_id
    end

    def load_categories
      @categories = Category.order_name :desc
    end
  end
end
