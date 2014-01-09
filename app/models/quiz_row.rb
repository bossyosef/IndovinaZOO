class QuizRow < ActiveRecord::Base
	    			
	#associazioni
	belongs_to :animal
	belongs_to :quiz				
end
