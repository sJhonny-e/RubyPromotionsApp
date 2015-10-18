require "checkout"

describe Checkout do

	before do
		@checkout = Checkout.new
	end

	describe "#scan" do

		before do
			@product = Product.new(7,"my title",55)
		end

		it "adds the product to the list of products" do
			@checkout.scan @product

			expect(@checkout.products).to include(@product)
		end

		it "throws on nil" do
			expect{@checkout.scan(nil)}.to raise_error(ArgumentError)
		end

	end

	describe "#total" do
		before do
			@costs5 = Product.new(1,"5 product",5)
			@costs10 = Product.new(2, "10 product", 10)
		end

		describe "simple total" do
			it "sums the price of one product" do
				@checkout.scan @costs10

				expect(@checkout.total).to eql(10.00)
			end

			it "sums the prices of two products" do
				@checkout.scan @costs5
				@checkout.scan @costs10

				expect(@checkout.total).to eql(15.00)
			end

			it "sums the prices of multiple products" do
				@checkout.scan @costs5
				@checkout.scan @costs10
				@checkout.scan @costs10
				@checkout.scan @costs10

				expect(@checkout.total).to eql(35.00)
			end
		end

		describe "with promotions" do

			it "invokes one promotion visitor" do
				promotion_double = double
				checkout_with_promotions = Checkout.new([promotion_double])

				expect(promotion_double).to receive(:visit).with(checkout_with_promotions)

				checkout_with_promotions.total
			end

			it "invokes multiple promotion visitors in order" do
				first_promotion = double("first")
				allow(first_promotion).to receive(:order).and_return(1)

				second_promotion = double("second")
				allow(second_promotion).to receive(:order).and_return(2)

				third_promotion = double("third")
				allow(third_promotion).to receive(:order).and_return(3)

				doubles = [ third_promotion, second_promotion,first_promotion] 
				checkout_with_promotions = Checkout.new(doubles)

				expect(first_promotion).to receive(:visit).with(checkout_with_promotions).ordered
				expect(second_promotion).to receive(:visit).with(checkout_with_promotions).ordered
				expect(third_promotion).to receive(:visit).with(checkout_with_promotions).ordered

				checkout_with_promotions.total
			end
		end


	end
end