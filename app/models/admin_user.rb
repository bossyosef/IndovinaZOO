# Questa classe descrive l'entità Utente Amministratore e le sue validazioni e operazioni.

class AdminUser < ActiveRecord::Base

  # Include i moduli Devise di default.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  
  # Validazioni effettuate sulle proprietà del Model.
       
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
