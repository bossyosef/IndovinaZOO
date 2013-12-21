class QuizzesController < ApplicationController
	before_action :set_quiz, only: [:show, :edit, :update, :destroy]
	before_action :init_quiz_insertions, only: [:new, :edit]
	before_action :authenticate_admin_user!, except: [:show, :index]

def index
	@quizzes = Quiz.all
end

def show
end

def new
	@quiz = Quiz.new
	
	#Crea due QuizRow per memorizzare gli animali			
	2.times { @quiz.quiz_rows.build	}
end

def create
	@quiz = Quiz.new(quiz_params)		
	prepare_quiz
	
	if @quiz.save
		flash[:success] = "Hai inserito un nuovo quiz!"
		redirect_to @quiz
	else
		render 'new'
	end
end

def edit
	@quiz.quiz_rows.build
end

def update	
	if @quiz.update(quiz_params)
		flash[:success] = "Quiz modificato con successo!"
		redirect_to @quiz
	else
		render 'edit'
	end
end

def destroy	
	@quiz.destroy
	
	flash[:success] = "Quiz eliminato con successo!"
	redirect_to quizzes_path
end

def select_animal_id
	if params[:id].present?
	  @animals = Animal.where.not(id: params[:id])
	else
	  @animals = Animal.all
	end
	
	respond_to do |format|
	  format.js
	end
end

private

def prepare_quiz
	# setta i valori corretti per le righe del quiz: quiz_id e animal_id.
	i = 0	
	@quiz.quiz_rows.each do |row|
		row.quiz_id = @quiz.id
		row.animal_id = params[:quiz][:quiz_rows_attributes][i.to_s][:animal_id]
		i += 1
	end
end

def set_quiz
	@quiz = Quiz.find(params[:id])
end

def init_quiz_insertions
	@animals = Animal.all(:order => 'name')
	@count = 0
end

def quiz_params
	params.require(:quiz).permit(:level, quiz_rows_attributes: [:id, :quiz_id, :animal_id])
end

end
