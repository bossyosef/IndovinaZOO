class Quiz < ActiveRecord::Base

	#variabili di classe per la gestione degli errori	
	@@error_message = ""
	
	#validazioni
	validates :level, presence: true,
					  numericality: { only_integer: true,
									  greater_than: 0,
									  less_than_or_equal_to: 10
									}
		
	#associazioni
	has_many :quiz_rows, dependent: :destroy
	has_many :animals, through: :quiz_rows
	accepts_nested_attributes_for :quiz_rows
	
	#metodi pubblici
	def self.verify_presence_of_quizzes		
		if !Quiz.any?			
			@@error_message = "Nessun quiz trovato."
		else			
			@@error_message = ""
		end		
	end
		
	def self.error_message
	  @@error_message
	end
	
	#metodi privati
	
	private 
	
	#validazione per quiz duplicati (DA SISTEMARE)
	def uniqueness_quiz_validation
		if Quiz.includes(:quiz_rows).where(animal_id: [7, 8]).count.select("quiz_id, count(*) as rows").group(:quiz_id).having("rows > 1")
			errors.add("Esiste già un quiz con gli animali scelti.")
		end
	end		
end
