class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(10)
    @cart_items = current_cart.cart_items.all    
    @subtotal = 0
    
  end

  def show
    @product = Product.find(params[:id])
    @cart_items = current_cart.cart_items.all
    @subtotal = 0
    @add_quantity = 1
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @cart_item = current_cart.add_cart_item(@product)
    @cart_item.quantity +=params[:current_quantity].to_i-1
    @cart_item.save!
    render :json => {:id => @product.id, :name => @product.name, :image =>@product.image.url, :quantity => @cart_item.quantity, :price => @product.price}
  end

end
