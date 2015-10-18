require "quantity_discount_promotion"

#There's probably a better way to mock this...
class Checkout_double
	attr_accessor :calculated_total, :products

	def initialize(total = 0)
		@calculated_total = total
	end
end

describe QuantityDiscountPromotion do
	before do
		@quantity_promotion = QuantityDiscountPromotion.new(1, 0.75)
	end

	describe "#initialize" do
		it "sets the correct id and price discount" do
			expect(@quantity_promotion.product_id).to eql 1
			expect(@quantity_promotion.discount_per_item).to eql 0.75
		end
	end

	describe "#order" do
		it "has order smaller than 100" do
			expect(@quantity_promotion.order).to be < 100
		end
	end

	describe "#visit" do
		it "doesn't change total when no matching product exists" do
			checkout_double = Checkout_double.new(100)

			product_double = double
			allow(product_double).to receive(:id).and_return(2)	
			checkout_double.products = [product_double]

			expect{@quantity_promotion.visit(checkout_double)}.to_not change{checkout_double.calculated_total}
		end

		it "doesn't change total when one matching product exists" do
			checkout_double = Checkout_double.new(100)

			product_double = double
			allow(product_double).to receive(:id).and_return(1)	
			checkout_double.products = [product_double]

			expect{@quantity_promotion.visit(checkout_double)}.to_not change{checkout_double.calculated_total}
		end

		it "changes total when two matching product exists, by 0.75 per product" do
			checkout_double = Checkout_double.new(100)

			product_double = double
			allow(product_double).to receive(:id).and_return(1)	#The lavender ID

			different_double = double
			allow(different_double).to receive(:id).and_return(2)
			checkout_double.products = [product_double, product_double, different_double, different_double]

			expect{@quantity_promotion.visit(checkout_double)}.to change{checkout_double.calculated_total}.by(-0.75 * 2)
		end
	end
end