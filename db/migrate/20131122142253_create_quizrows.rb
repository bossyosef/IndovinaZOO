class CreateQuizrows < ActiveRecord::Migration
  def change
    create_table :quizrows do |t|
      t.integer :animal_id
      t.integer :quiz_id

      t.timestamps
    end
  end
end
