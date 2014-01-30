class GameController < ApplicationController
  def home
  end

  def settings
	@livello_alto, @quantita_quiz, @numero_quiz = Quiz.levels_hash
	gon.livello_alto = @livello_alto
	gon.quantita_quiz = @quantita_quiz
	gon.numero_quiz = @numero_quiz.to_json
  end

  def quiz
	if !params[:iniziato]
	  @quiz_arr, @animali_arr, @soluzioni_arr = Quiz.random_quiz_array(params[:numeroquiz],params[:livelloquiz],params[:standard])
	  gon.quiz_arr = @quiz_arr
	  gon.animali_arr = @animali_arr
	  gon.soluzioni_arr = @soluzioni_arr
	end
	gon.to = params[:timeout].to_i*100
	gon.tos = params[:timeout]
	gon.id = params[:id]
	gon.nq = params[:numeroquiz]
  end

  def result
    @rank = Rank.new
  end
  
  def error
  end
end
