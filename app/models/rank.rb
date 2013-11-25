class Rank < ActiveRecord::Base
	
	validates :nickname,
							presence: true

	validates :score,
							presence: true,
							:numericality => {:greater_than => 0}

 	def self.top5
		order(:score).reverse_order.first(5)
	end

end
