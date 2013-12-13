class QuizRow < ActiveRecord::Base
	    			
	#associazioni
	belongs_to :animal
	belongs_to :quiz, inverse_of: :quiz_rows
	
	#validazioni
	validates :quiz_id, presence: true
	validates :animal_id, presence: true
		
end
