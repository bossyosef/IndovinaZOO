class QuizRow < ActiveRecord::Base
	    			
	#associazioni
	belongs_to :animal
	belongs_to :quiz
	
	#validazioni
	validates_presence_of :animal
	validates_presence_of :quiz
		
end
