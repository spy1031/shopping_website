class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def edit
    @order = Order.find(params[:id])
  end
end
