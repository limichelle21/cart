class CartsController < ApplicationController
  
  def show
  	@order_items = current_order.order_items
  end

  # only one cart should be accessed at a time and display only current_order items
end
