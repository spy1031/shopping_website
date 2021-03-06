class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart

  private

  def current_cart
    @cart || set_cart
  end

  def set_cart

    if session[:cart_id]
      @cart = Cart.find_by(id: session[:cart_id])
    end

    @cart ||= Cart.create

    session[:cart_id] = @cart.id
    @cart
  end


  def after_sign_in_path_for(resource)

    # redirect to the form if there is a form_data in the session
    if session[:form_data].present?

      #redirect to your form path
      return cart_items_path
    else
      #if there is not temp list in the session proceed as normal
      super
    end

  end

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end


end
