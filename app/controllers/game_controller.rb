class GameController < ApplicationController
  def home
  end

  def settings
	@livello_alto, @quantita_quiz, @numero_quiz = Quiz.levels_hash
  end

  def quiz
	  if !params[:iniziato]
	    @quiz_arr, @animali_arr = Quiz.random_quiz_array(params[:numeroquiz],params[:livelloquiz],params[:standard])
	  end
  end

  def result
    @rank = Rank.new
  end
  
  def error
  end
end
