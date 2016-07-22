class ProductsController < ApplicationController
  def index
  	@products = Product.all
  	@order_item = current_order.order_items.new
  end

  # will create a new instance of OrderItem model to use in the forms
end
