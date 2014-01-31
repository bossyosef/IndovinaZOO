class Quiz < ActiveRecord::Base
  include ActiveModel::Validations
  
  #variabili di classe per la gestione degli errori	
  @@error_message = ""
  
  #validazioni
  validates :level, presence: true,
					numericality: { only_integer: true,
									greater_than: 0,
									less_than_or_equal_to: 3
								  }
  
  #gestisce la verifica della presenza di quiz duplicati.	
  validate :uniqueness_quiz_validator
  
  #associazioni
  has_many :quiz_rows, dependent: :destroy
  has_many :animals, through: :quiz_rows
  accepts_nested_attributes_for :quiz_rows
  
  #metodi pubblici per la gestione dei quiz

  #ritorna un messaggio di errore se non sono presenti quiz	
  def self.verify_presence_of_quizzes		
	  if !Quiz.any?			
		  @@error_message = "Nessun quiz trovato."
	  else			
		  @@error_message = ""
	  end		
  end

  def self.error_message
	@@error_message
  end
	  
  #metodi pubblici per il gioco
	  
  def prepare_quiz(animal_ids)		
	  # setta i valori corretti per le righe del quiz: quiz_id e animal_id.
	  i = 0
	  self.quiz_rows.each do |row|
		  row.animal_id = animal_ids[i]
		  i += 1
	  end
  end
  
  #ritorna un animale a caso
  def random_animal
	  animals.sample
  end
  
  #ritorna gli animali appartenenti al quiz con l'id passato come parametro
  def self.get_animals_from_id(idquiz)
	  animal1 = find(idquiz).animals.first
	  animal2 = find(idquiz).animals.last
	  return animal1,animal2
  end

  #ritorna un array composto da numQuiz Quiz,un array di animali dei quiz e un array con le risposte esatte
  #se numQuiz vale 0 allora si ritornano un array standard con 4 quiz di livello 1, 4 di livello 2 e 2 di livello 3, con gli animali e le risposte
  def self.random_quiz_array(numQuiz,livello,standard)
	if(standard == "no")
	  livelloQuiz = livello.to_i
	  if (livelloQuiz == 0)
		quizzes = self.all
	  else
		quizzes = self.where(:level => livelloQuiz)
	  end
	  quiz_arr = []
	  animal_arr = []
	  solution_arr = []
	  numQuiz.to_i.times do
		  q1 = quizzes.sample
		  quiz_arr.push(q1)
		  animal_arr.push(q1.animals)
		  solution_arr.push(q1.random_animal.cry)
		  quizzes.delete_if {|q| q == q1}		
	  end
	  return quiz_arr, animal_arr, solution_arr
	else
	  ar1 = self.where(:level => 1).sample(4)
	  ar2 = self.where(:level => 2).sample(4)
	  ar3 = self.where(:level => 3).sample(2)
	  quiz_arr = ar1 + ar2 + ar3
	  animal_arr = []
	  solution_arr = []
	  10.times do |i|
		animal_arr.push(quiz_arr[i].animals)
		solution_arr.push(quiz_arr[i].random_animal.cry)
	  end
	  return quiz_arr, animal_arr, solution_arr
	end
  end
  
  #la funzione restituisce il livello più alto tra i quiz presenti nel DB e un hash contenente l'associazione livello -> numero quiz di quel livello
  def self.levels_hash
	quizzes = self.all.to_a
	quiz_count = quizzes.length
	level_arr = []
	highest_level = 1
	quizzes.each do |quiz|
	  level_arr.push(quiz.level)
	  if quiz.level > highest_level
		highest_level = quiz.level
	  end
	end
	level_count = Hash[level_arr.group_by{|i| i }.map{|k,v| [k,v.size]}]
	return highest_level, level_count, quiz_count
  end
  
  private
  
  def uniqueness_quiz_validator
	first_animal_id = self.quiz_rows.first.animal_id
	second_animal_id = self.quiz_rows.last.animal_id
	if QuizRow.select("quiz_id, count(*)").where(animal_id: [ first_animal_id, second_animal_id ]).group(:quiz_id).having("count(*) > ?", 1).any?
		self.errors[:base] << "Esiste già un quiz con gli animali scelti!"
	end
  end
end