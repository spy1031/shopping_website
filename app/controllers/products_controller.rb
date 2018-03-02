class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(10)
    @cart_items = current_cart.cart_items.all
    @subtotal = 0
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @cart_item = current_cart.add_cart_item(@product)

    render :json => {:id => @product.id, :name => @product.name, :image =>@product.image.url, :quantity => @cart_item.quantity, :price => @product.price}
  end

end
