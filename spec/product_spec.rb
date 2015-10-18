require "product"
describe Product do
	
	it "has an id" do
		product = Product.new(1)
		expect(product.id).to eql(1)
	end

	it "has a name" do
		name = "product name"
		product = Product.new(9,name)

		expect(product.name).to eql(name)
	end

	it "has a price" do
		price = 5.78
		product = Product.new(5,"name",price)

		expect(product.price).to eql(price)
	end

end