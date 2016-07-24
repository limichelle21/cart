class Order < ActiveRecord::Base

	belongs_to :order_status
	has_many :order_items

	# this occurs when an order is created - set status to 1 (in Progress)
	before_create :set_order_status

	# This called before save - sum order item's total cost and stores in subtotal field
	before_save :update_subtotal


	# This looks through array of order_items - if OI is valid, then multiply OI quantity by unit price, sum of all OI prices
	def subtotal
		order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
	end

	private

		def set_order_status
			self.order_status_id = 1
		end

		def update_subtotal
			self[:subtotal] = subtotal
		end


end
