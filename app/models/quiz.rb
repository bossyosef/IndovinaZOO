class Quiz < ActiveRecord::Base
	has_many :quizrows
	has_many :animals, :through => :quizrows
end
