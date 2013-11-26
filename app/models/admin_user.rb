class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  #validazioni personalizzate
  validates :username, :presence => true,
					   :uniqueness => true,
					   :format => { :with => /[\w-]+/ },   #accetta solo caratteri alfanumerici
					   :length => { in: 5..12 }
  
  validates :email, :format => { :with => /[^@]+@[^@]+\.[a-zA-Z]{2,6}/ }
  
  validates :fullname, :presence => true,
					   :format => { :with => /[a-zA-Z]+/ }   
  
end
