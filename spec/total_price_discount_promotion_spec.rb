require "total_price_discount_promotion"

#There's probably a better way to mock this...
class CheckoutDouble
	attr_accessor :calculated_total

	def initialize(total = 0)
		@calculated_total = total
	end
end

describe TotalPriceDiscountPromotion do
	before do
		@total_price_promotion = TotalPriceDiscountPromotion.new(60, 0.1)
	end

	describe "#initialize" do
		it "sets the correct price limit and discount" do
			promotion = TotalPriceDiscountPromotion.new(7,0.9)
			expect(promotion.price_limit).to eql 7
			expect(promotion.discount_percentage).to eql 0.9
		end

		it "fails when discount percentage is larger than 1" do
			expect{TotalPriceDiscountPromotion.new(8,1.1)}.to raise_error(ArgumentError)
		end

		it "fails when discount percentage is smaller than 0" do
			expect{TotalPriceDiscountPromotion.new(8, -0.1)}.to raise_error(ArgumentError)
		end

		it "failes when price limit is smaller than 0" do
			expect{TotalPriceDiscountPromotion.new(-1,0.1)}.to raise_error(ArgumentError)
		end
	end

	describe "#order" do
		it "has order larger than 100" do
			expect(@total_price_promotion.order).to be > 100
		end
	end

	describe "#visit" do
		it "doesn't change total when the total is 0" do
			checkout_double = CheckoutDouble.new

			expect{@total_price_promotion.visit(checkout_double)}.to_not change{checkout_double.calculated_total}
		end

		it "doesn't change total when it's exactly the limit" do
			checkout_double = CheckoutDouble.new(60)

			expect{@total_price_promotion.visit(checkout_double)}.to_not change{checkout_double.calculated_total}
		end

		it "decreases total by 10% when it's over the limit" do
			checkout_double = CheckoutDouble.new(61)

			expect{@total_price_promotion.visit(checkout_double)}.to change{checkout_double.calculated_total}.from(61).to(54.9)
		end
	end
end