class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
         
  validates :username, presence: true,
					   length: { in: 5..12 }

  validates :password, presence: true,
					   confirmation: true,
					   length: { in: 5..10 }
  
  validates :password_confirmation, presence: true
   				   
  validates :email, format: { with: /\A[^@]+@[^@]+\.[^@]{2,6}\z/ },
				    allow_blank: true
  
  validates :name, length: { maximum: 35 },
				   format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters." },
				   allow_blank: true
				   
  validates :surname, length: { maximum: 50 },
				      format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters." },
				      allow_blank: true  
end
