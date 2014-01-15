class GameController < ApplicationController
  def home
  end

  def settings
	@livello_alto, @quantita_quiz, @numero_quiz = Quiz.levels_hash
  end

  def quiz
	if(params[:iniziato])
	  @animale1, @animale2 = Quiz.get_animals_from_id(params[:quiz])
	  @verso = Animal.get_cry(params[:animale])
	else
	  @quiz_arr, @animali_arr = Quiz.random_quiz_array(params[:numeroquiz],params[:livelloquiz])
	  @animale1, @animale2 = Quiz.get_animals_from_id(@quiz_arr[0].id)
	  @verso = Animal.get_cry(@animali_arr[0])
	end
  end

  def result
  end
  
  def error
  end
end
