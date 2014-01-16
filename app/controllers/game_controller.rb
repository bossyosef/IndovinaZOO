class GameController < ApplicationController
  def home
  end

  def settings
	@livello_alto, @quantita_quiz, @numero_quiz = Quiz.levels_hash
  end

  def quiz
	if(!params[:iniziato])
	  @quiz_arr, @animali_arr = Quiz.random_quiz_array(params[:numeroquiz],params[:livelloquiz])
	end
  end

  def result
  end
  
  def error
  end
end
