class Quizrow < ActiveRecord::Base
	belongs_to :animal
	belongs_to :quiz
end
