class Quiz < ActiveRecord::Base
	
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
	
	#metodi pubblici per il gioco
	
	def random_animal
		animals.sample
	end
		
	def self.get_animals_from_id(idquiz)
		animal1 = find(idquiz).animals.first
		animal2 = find(idquiz).animals.last
		return animal1,animal2
	end

	def self.random_quiz_array(numQuiz)
		quizzes = self.all
		quiz_id_arr = [] 
		animal_arr = []
		answer_arr = []
		score_arr = []
		numQuiz.to_i.times do
			q1 = quizzes.sample											#scelgo a caso un quiz
			quiz_id_arr.push(q1.id)									#copio l'id del quiz 
			animal_arr.push(q1.random_animal.name)	#copio il nome di uno dei due animali scelti a caso
			quizzes.delete_if {|q| q.id == q1.id}		
		end
		return quiz_id_arr, animal_arr
	end
	
	#metodi pubblici per la creazione dei quiz
	def self.get_index_page_errors
		if !Animal.any?
			"Nessun animale trovato per creare nuovi quiz."
		elsif Animal.count < 2
			"Devi creare almeno un altro animale."		
		elsif !Quiz.any?
			"Nessun quiz trovato."
		end
	end
	
	def self.current_animals_count
		Animal.count
	end		
end
