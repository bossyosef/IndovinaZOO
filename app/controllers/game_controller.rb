class GameController < ApplicationController
  def home
  end

  def settings
  end

  def quiz
	if(params[:quiz_id_arr])
	  @animale1, @animale2 = Quiz.get_animals_from_id(params[:quiz_id_arr][params[:id].to_i-1])
	  @verso = Animal.get_cry(params[:animali_arr][params[:id].to_i-1])
	else
	  @quiz_id_arr, @animali_arr, @risposte_arr, @punteggi_arr = Quiz.random_quiz_array(params[:numeroquiz])
	end
  end

  def result
  end
end
