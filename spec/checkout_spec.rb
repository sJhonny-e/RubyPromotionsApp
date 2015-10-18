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
			it "sums the prices of one product" do
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
				promotionDouble = double
				checkoutWithPromotions = Checkout.new([promotionDouble])

				expect(promotionDouble).to receive(:visit).with(checkoutWithPromotions)

				checkoutWithPromotions.total
			end

			it "invokes multiple promotion visitors in order" do
				firstPromotion = double("first")
				allow(firstPromotion).to receive(:order).and_return(1)

				secondPromotion = double("second")
				allow(secondPromotion).to receive(:order).and_return(2)

				thirdPromotion = double("third")
				allow(thirdPromotion).to receive(:order).and_return(3)

				doubles = [ thirdPromotion, secondPromotion,firstPromotion] 
				checkoutWithPromotions = Checkout.new(doubles)

				expect(firstPromotion).to receive(:visit).with(checkoutWithPromotions).ordered
				expect(secondPromotion).to receive(:visit).with(checkoutWithPromotions).ordered
				expect(thirdPromotion).to receive(:visit).with(checkoutWithPromotions).ordered

				checkoutWithPromotions.total
			end
		end


	end
end