class AnimalsController < ApplicationController  
  before_action :set_animal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!, except: [:show, :index]
  
	def new
		@animal = Animal.new
	
		respond_to do |format|
			format.html { render :layout => !request.xhr? }
		end	
	end

	def create		
		@animal = Animal.new(animal_params)
	
		if @animal.save
			flash[:success] = "Animale creato correttamente!"
			respond_to do |format|		 
			  format.js		 
			end
		end
	end

	def show	
	end

	def index
		@animals = Animal.all
		Animal.verify_presence_of_animals
		@animal = Animal.new
	end

	def edit	
	end

	def update	
		if @animal.update(animal_params)
			flash[:success] = "Animale modificato correttamente!"
			redirect_to @animal
		else
			render "edit"
		end
	end

	def destroy	
		@animal.destroy
	
		redirect_to animals_path
	end

	private
	
	def set_animal
		@animal = Animal.find(params[:id])
	end
	
	def animal_params
		params.require(:animal).permit(:name, :image, :cry)
	end
end
