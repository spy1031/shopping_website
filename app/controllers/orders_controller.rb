class OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end

  def create
    if current_user.nil?
      session[:form_data] = params[:order]
      redirect_to new_user_session_path
    else
      @order = Order.new(order_params)
      @cart_items = current_cart.cart_items.all
      @order.user_id = current_user.id
      @order.sn = 1000000 + Order.count
      @order.payment_status = "Not Paid"
      @order.shipping_status = "Not shipped"
      @order.email = current_user.email
      @order.amount = 0
      if @order.save
        @cart_items.each do |item|
          order_item = @order.order_items.build(product_id: item.product.id, price: item.product.price, quantity: item.quantity)
          @order.amount += item.product.price * item.quantity
          order_item.save!
        end
        @order.save!
        session[:card_id] = nil #訂單成立清空購物車
        current_cart = nil
        UserMailer.notify_order_create(@order).deliver_now! #寄送訂單成立email
        redirect_to order_path(@order)
      else
        @subtotal =0;
        flash[:alert] = @order.errors.full_messages.to_sentence
        render 'cart_items/index.html.erb'
      end
    
      
    end
      

    
  end


  def show
    @order = Order.find(params[:id])
    
  end

  def destroy
    @order= Order.find(params[:id])
    if @order.shipping_status == "Not shipped"
      @order.destroy
      redirect_to orders_path
      flash[:notice] = "Order was successfully canceled"
    else
      render :index
      flash[:alert] = "Not allow! Order was shipping"
    end
    
  end

  def order_params
    params.require(:order).permit(:name, :phone, :address)
  end
end
