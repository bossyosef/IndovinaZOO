class RanksController < ApplicationController
	make_resourceful do
		actions :index
	end 

#	def index
#			@ranks = Rank.top5
#	end

	def top5
			@ranks = Rank.top5
	end
end
