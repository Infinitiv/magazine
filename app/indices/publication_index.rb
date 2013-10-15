ThinkingSphinx::Index.define :publication, :with => :active_record do
  indexes title_ru, title_en, keywords_ru, keywords_en, abstract_ru, abstract_en, authors_ru, authors_en
  indexes issue.year, :as => :year
  indexes issue.volume, :as => :volume
  indexes issue.number, :as => :number  
end