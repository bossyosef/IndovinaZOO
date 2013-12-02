class GameController < ApplicationController
  def home
  end

  def settings
  end

  def quiz
	if(params[:quiz_id_arr])
	  @immagine1 = Quiz.find
	  @immagine2 = 
	  @verso = Quiz.find(params[:quiz_id_arr][params[:id].to_i-1])
	else
	  @quiz_id_arr, @animali_arr, @risposte_arr, @punteggi_arr = Quiz.random_quiz_array(params[:numeroquiz])
	end
  end

  def result
  end
end
