class Rank < ActiveRecord::Base
	
	validates :nickname, presence: true
	validates :score, presence: true,
				      numericality: {greater_than_or_equal_to: 0}


  #classifica dei primi 5 punteggi
 	def self.top5
		order(:score).reverse_order.first(5)
	end

end
