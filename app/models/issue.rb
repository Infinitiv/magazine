class Issue < ActiveRecord::Base
  has_many :publications
  has_many :attachments, :through => :attachments_issues
  
  validate :year, :volume, :number, :presence => true
end
