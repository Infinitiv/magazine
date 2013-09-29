class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title_ru
      t.text :title_en
      t.text :content_ru
      t.text :content_en
      t.references :article_type, index: true
      t.date :expire
      t.boolean :published
      t.text :cut_content_ru
      t.text :cut_content_en

      t.timestamps
    end
  end
end
