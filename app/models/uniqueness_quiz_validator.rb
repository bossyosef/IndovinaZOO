class UniquenessQuizValidator < ActiveModel::Validator
	def validate(quiz)
		first_animal_id = quiz.quiz_rows.first.animal_id
		second_animal_id = quiz.quiz_rows.last.animal_id
		if QuizRow.select("quiz_id, count(*)").where(animal_id: [ first_animal_id, second_animal_id ]).group(:quiz_id).having("count(*) > ?", 1).any?
			quiz.errors[:base] << "Esiste già un quiz con gli animali scelti!"
		end
	end
end
