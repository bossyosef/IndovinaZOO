require 'carrierwave/orm/activerecord'

class Animal < ActiveRecord::Base
	
	validates :name, presence: true,
					 length: { maximum: 15 }		
	
	validates :image, presence: true	
	validate :image_size_validation
	
	validates :cry, presence: true	
	validate :cryfile_size_validation		
	
	mount_uploader :image, AnimalImageUploader
	
	mount_uploader :cry, AnimalCryUploader
	
	#associazioni
	has_many :quiz_rows
	has_many :quizzes, through: :quiz_rows
	
	#metodi pubblici
	
	def self.get_cry(animale)
	  where(name: animale).cry
	end	
	
	private
	def image_size_validation
		errors[:image] << "Il file deve essere più piccolo di 5 MB." if image.size > 5.megabytes
	end
		
	def cryfile_size_validation
		errors[:cry] << "Il file deve essere più piccolo di 5 MB." if cry.size > 5.megabytes
	end	

end


