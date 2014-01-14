class QuizRow < ActiveRecord::Base
	    			
	#associazioni
	belongs_to :animal
	belongs_to :quiz
	
	validates_presence_of :animal_id
end
