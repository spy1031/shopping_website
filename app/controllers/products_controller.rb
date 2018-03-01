class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(10)
    @cart_items = current_cart.cart_items
    if @cart_items != nil
      @cart_products = Array.new
      @cart_items.each do |item|
        @cart_products << item.product 
      end
    end
  end

  def add_to_cart
    @product = Product.find(params[:id])
    current_cart.add_cart_item(@product)

    redirect_to root_path
  end

end
