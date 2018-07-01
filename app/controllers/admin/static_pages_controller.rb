module Admin
  class StaticPagesController < AdminController
    def home
      @users = User.newest
      @orders = Order.newest
      @products = Product.newest
    end
  end
end
