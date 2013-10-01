class Article < ActiveRecord::Base
  belongs_to :type
  has_and_belongs_to_many :attachments
  validate :title_ru, :content_ru, :article_type_id, :presence => true
end
