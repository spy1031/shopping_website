class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @order = Order.new(order_params)
    @cart_items = current_cart.cart_items.all
    @order.user_id = current_user.id
    if @order.save!
      @cart_items.each do |item|
        order_item = @order.order_items.build(product_id: item.product.id, price: item.product.price, quantity: item.quantity)
        order_item.save!
      end

    end
    redirect_back(fallback_location: root_path)
  end


  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :payment_status)
  end
end
