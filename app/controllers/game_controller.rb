class GameController < ApplicationController
  def home
  end

  def settings
  end

  def quiz
	if(params[:iniziato])
	  @animale1, @animale2 = Quiz.get_animals_from_id(params[:quiz])
	  @verso = Animal.get_cry(params[:animale])
	else
	  @quiz_arr, @animali_arr = Quiz.random_quiz_array(params[:numeroquiz])
	  @animale1, @animale2 = Quiz.get_animals_from_id(@quiz_arr[0].id)
	  @verso = Animal.get_cry(@animali_arr[0])
	end
  end

  def result
  end
end
