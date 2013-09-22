json.array!(@publications) do |publication|
  json.extract! publication, :title_ru, :title_en, :authors_ru, :authors_en, :keywords_ru, :keywords_en, :abstract_ru, :abstract_en, :book_id
  json.url publication_url(publication, format: :json)
end
