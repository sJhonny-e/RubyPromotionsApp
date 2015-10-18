class TotalPriceDiscountPromotion
	def order
		101
	end

	attr_accessor :price_limit, :discount_percentage

	def initialize(price_limit, discount_percentage)
		if discount_percentage < 0 || discount_percentage > 1
			raise ArgumentError.new("discount percentage must be between 0 and 1")
		end
		if price_limit < 0 
			raise ArgumentError.new("price limit must be larger than 0")
		end
		@price_limit = price_limit
		@discount_percentage = discount_percentage
	end

	def visit(checkout)
		if checkout.calculated_total <= @price_limit 
			return
		end
		checkout.calculated_total *= (1 - @discount_percentage)
	end
end