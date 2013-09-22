class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.text :title_ru
      t.text :title_en
      t.text :authors_ru
      t.text :authors_en
      t.text :keywords_ru
      t.text :keywords_en
      t.text :abstract_ru
      t.text :abstract_en
      t.references :issue, index: true

      t.timestamps
    end
  end
end
