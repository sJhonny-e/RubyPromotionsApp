class QuantityDiscountPromotion
	def order
		1
	end

	attr_accessor :product_id, :discount_per_item

	def initialize(product_id, discount_per_item)
		@product_id = 1
		@discount_per_item = discount_per_item
	end

	def visit(checkout)
		count = checkout.products.count {|p| p.id == @product_id}
		if count < 2
			return
		end

		checkout.calculated_total -=  count * discount_per_item
	end
end