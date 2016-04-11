# RubyPromotionsApp
My very first experiment with Ruby and with TDD

A very simple checkout program developed in TDD using RSpec.  
You can define different `Product`s and different `Promotion`s;  
##Usage
Initialize your `Checkout` object with the `Promotion`s you've created, and start `scan`ning different `Product`s.  
When you call the `total` method, the total price to pay will be calcualted based on the products scanned, and the active promotions you've defined.  

##A little about
Currently 2 types of promotions are implemented -  
* `QuantityDiscountPromotion` awards a certain discount % for all occurances of a given product if it's present more than 2 times.  
(i.e 'If you buy 2 or more t-shirts, you get each at a 30% discount')     
* `TotalPriceDiscountPromotion` awards a certain discount % if the total sum of purchase is larger than a defined threshold.  
(i.e '20% off your order total if you spend more than 100$')     

Since promotions affect the total price using a simple Visitor pattern, it's very easy to add or remove promotions with whatever custom logic you'd like.   

If you want to dive a bit deeper, I suggest taking a look at the `spec` folder to see how this thing works :)
