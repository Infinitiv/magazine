class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :question
      t.text :answer
      t.boolean :public

      t.timestamps
    end
  end
end
