class OrderItem < ActiveRecord::Base

  belongs_to :product
  belongs_to :order


  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  

  # The following are custom validations
  validate :product_present
  validate :order_present


  # calls Finalize function before each save
  before_save :finalize

  #if OI already exists, unit price should be the product price at time of record saved. If not, use current product price
  def unit_price
  	if persisted?
  		self[:unit_price]
  	else
  		product.price
    end
  end

  def total_price
  	unit_price * quantity
  end


  private

    def product_present
    	if product.nil?
    		errors.add(:product, "is not valid or is not active.")
    	end
    end

    def order_present
    	if order.nil?
    		errors.add(:order, "is not a valid order.")
    	end
    end

    # sets item's unit price and total price before saving
    def finalize
    	self[:unit_price] = unit_price
    	self[:total_price] = quantity * self[:unit_price]
    end


end

