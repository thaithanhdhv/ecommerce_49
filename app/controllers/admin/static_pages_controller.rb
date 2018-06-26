module Admin
  class StaticPagesController < ApplicationController
    def home
      @users = User.all
      @orders = Order.all
      @product = Product.all
    end
  end
end
