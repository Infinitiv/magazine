class Article < ActiveRecord::Base
  belongs_to :type
  validate :title_ru, :content_ru, :article_type_id, :presence => true
end
