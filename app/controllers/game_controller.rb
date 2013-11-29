class GameController < ApplicationController
  def home
  end

  def settings
  end

  def quiz
	#if (params[:risultati])
	#  @quiz, @risposta = Quiz.random(params[:risultati])
	#else
	#  @risultati.random_quiz_array(params[:numeroquiz])
	#end
  end

  def result
  end
end
