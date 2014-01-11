require 'carrierwave/orm/activerecord'

class Animal < ActiveRecord::Base
	
	#variabili di classe per la gestione degli errori	
	@@error_message = ""
	
	#validazioni	
	validates :name, presence: true,
					 length: { maximum: 15 }		
	
	validates :image, presence: true	
	validate :image_size_validation, on: :create
	
	validates :cry, presence: true	
	validate :cryfile_size_validation, on: :create		
	
	mount_uploader :image, AnimalImageUploader
	
	mount_uploader :cry, AnimalCryUploader
	
	#associazioni
	has_many :quiz_rows
	has_many :quizzes, through: :quiz_rows
	
	#metodi pubblici
	def self.verify_presence_of_animals				
		if !Animal.any?			
			@@error_message = "Nessun animale trovato."
		else			
			if Animal.count < 2				
				@@error_message = "Crea almeno 2 animali per creare un quiz."
			else
				@@error_message = ""
			end
		end
	end
	
	def self.min_animals_to_make_a_quiz?
	  if Animal.count >= 2
		true
	  else
		false
	  end
	end
	
	def self.error_message
	  @@error_message
	end
	
	#metodi privati
		
	private
	
	#metodi per validazioni
	
	def image_size_validation
		errors[:image] << "Il file deve essere più piccolo di 5 MB." if image.size > 5.megabytes
	end
		
	def cryfile_size_validation
		errors[:cry] << "Il file deve essere più piccolo di 5 MB." if cry.size > 5.megabytes
	end
	
end
