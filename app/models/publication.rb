class Publication < ActiveRecord::Base
  belongs_to :issue
  has_and_belongs_to_many :attachments
  
  validates :title_ru, :authors_ru, :keywords_ru, :abstract_ru, :issue_id, :presence => true
end
