class Quiz < ActiveRecord::Base
	has_many :quizrows
	has_many :animals, :through => :quizrows

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
		numQuiz.times do {
			q1 = quizzes.sample											#scelgo a caso un quiz
			quiz_id_arr.push(q1.id)									#copio l'id del quiz 
			animal_arr.push(q1.random_animal.name)	#copio il nome di uno dei due animali scelti a caso
			answer_arr.push(0)
			score_arr.push(0)
			quizzes.delete_if {|q| q.id == q1.id}
		}
		end
		return [quiz_id_arr, animal_arr, answer_arr, score_arr]
	end
end
