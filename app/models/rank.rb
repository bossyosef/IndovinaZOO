class Rank < ActiveRecord::Base
	
	validates :nickname,
							presence: true

	validates :score,
							presence: true,
							:numericality => {:greater_than => 0}

end
