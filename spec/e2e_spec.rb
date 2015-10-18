require "checkout"

describe "checkout program" do
	before do
		@lavender_heart = Product.new(1, "Lavender heart", 9.25)
		@cufflinks = Product.new(2,"Personalised cufflinks",45)
		@kids_t_shirt = Product.new(3, "Kids T-shirt",19.95)

		@lavenderPromotion = QuantityDiscountPromotion.new(1, 0.75)
		@overSixtyPromotion = TotalPriceDiscountPromotion.new(60, 0.1)

		@checkout = Checkout.new([@lavenderPromotion, @overSixtyPromotion])
	end

	it "comes out £66.78 when there's one of each product" do
		@checkout.scan @lavender_heart
		@checkout.scan @cufflinks
		@checkout.scan @kids_t_shirt

		expect(@checkout.total).to eql(66.78)
	end

	it "comes out £36.95 with 2 lavender hearts and a t-shirt" do
		@checkout.scan @lavender_heart
		@checkout.scan @kids_t_shirt
		@checkout.scan @lavender_heart

		expect(@checkout.total).to eql(36.95)
	end

	it "comes out £73.76 with 2 lavender hearts and one of each other product" do
		@checkout.scan @lavender_heart
		@checkout.scan @cufflinks
		@checkout.scan @lavender_heart
		@checkout.scan @kids_t_shirt

		expect(@checkout.total).to eql(73.76)
	end

end