class Publication < ActiveRecord::Base
  belongs_to :issue
  has_many :attachments, :through => :attachments_publications
  
  validates :title_ru, :authors_ru, :keywords_ru, :abstract_ru, :issue_id, :presence => true
end
