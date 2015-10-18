class Product
	attr_accessor :id, :name, :price
	
	def initialize (id = 0, name = nil, price = 0)
		@id = id
		@name = name
		@price = price
	end
end