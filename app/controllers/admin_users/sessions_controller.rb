# SessionsController - Controller personalizzato che eredita dal controller
# Devise le funzionalità di base. Gestisce le viste riguardanti la creazione
# e l'eliminazione di sessioni utente.

class AdminUsers::SessionsController < Devise::SessionsController    
	def home
	end	
end

