class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  validates_presence_of :name, :email, :phone, :adress, :payment_status
  
end
