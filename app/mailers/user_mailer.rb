class UserMailer < ApplicationMailer
  default from: "My Cart <info@spy.co>"

  def notify_order_create(order)
    @order = order
    @content = "Your order is created. Thank you!"

    mail to: order.user.email,
    subject: "SPY | 訂單成立: #{@order.id}"
  end
end
