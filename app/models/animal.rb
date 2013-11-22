require 'carrierwave/orm/activerecord' #da verificare

class Animal < ActiveRecord::Base
	
	validates :name,
							presence: true

	validates :image,
							presence: true

	validates :cry,
							presence: true

	mount_uploader :image, ImageUploader

	mount_uploader :cry, CryUploader

	has_many :quizrows
	has_many :quizzes, :through => :quizrows

end


