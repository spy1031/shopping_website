class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
end


def add_cart_item(product)
  existing_item =self.cart_items.find_by(product_id: product)
  if existing_item
    existing_item.quantity+=1
    existing_item.save!
  else
    cart_item = cart_items.build(product_id: product)
    cart_item.save!
  end
  self.cart_items
end