require "quantity_discount_promotion"

#There's probably a better way to mock this...
class CheckoutDouble
	attr_accessor :calculated_total, :products

	def initialize(total = 0)
		@calculated_total = total
	end
end

describe QuantityDiscountPromotion do
	before do
		@quantity_promotion = QuantityDiscountPromotion.new(1, 0.75)
	end

	describe "#order" do
		it "has order smaller than 100" do
			expect(@quantity_promotion.order).to be < 100
		end
	end

	describe "#visit" do
		it "doesn't change total when no matching product exists" do
			checkoutDouble = CheckoutDouble.new(100)

			productDouble = double
			allow(productDouble).to receive(:id).and_return(2)	
			checkoutDouble.products = [productDouble]

			expect{@quantity_promotion.visit(checkoutDouble)}.to_not change{checkoutDouble.calculated_total}
		end

		it "doesn't change total when one matching product exists" do
			checkoutDouble = CheckoutDouble.new(100)

			productDouble = double
			allow(productDouble).to receive(:id).and_return(1)	
			checkoutDouble.products = [productDouble]

			expect{@quantity_promotion.visit(checkoutDouble)}.to_not change{checkoutDouble.calculated_total}
		end

		it "changes total when two matching product exists, by 0.75 per product" do
			checkoutDouble = CheckoutDouble.new(100)

			productDouble = double
			allow(productDouble).to receive(:id).and_return(1)	#The lavender ID

			differentDouble = double
			allow(differentDouble).to receive(:id).and_return(2)
			checkoutDouble.products = [productDouble, productDouble, differentDouble, differentDouble]

			expect{@quantity_promotion.visit(checkoutDouble)}.to change{checkoutDouble.calculated_total}.by(-0.75 * 2)
		end
	end
end