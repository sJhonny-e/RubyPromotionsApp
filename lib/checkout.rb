class Checkout
	attr_accessor :products, :calculated_total, :promotions

	def initialize(promotions =[])
		@products = []
		@promotions = promotions
	end


	def scan(product)
		if product == nil
			raise ArgumentError.new('product cannot be nil')
		end
		@products << product
	end

	def total
		@calculated_total = @products.inject(0) { |sum, product| sum + product.price}

		#go over the promotions by order
		@promotions.sort! {|x,y| x.order <=> y.order}
		@promotions.each do |promotion| 
			promotion.visit self
		end

		@calculated_total.round(2)
	end
end