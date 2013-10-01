class Issue < ActiveRecord::Base
  has_many :publications
  has_and_belongs_to_many :attachments
  
  validate :year, :volume, :number, :presence => true

  def self.import(file)
  	xml = Nokogiri::XML(File.open(file.tempfile.path))
  	if xml.css("journals").count > 0
      year = xml.at_css("issue jdateUni").content
  	  volume = xml.at_css("issue jvolUni").content
  	  number = xml.at_css("issue jnumUni").content
  	  issue = where(year: year, volume: volume, number: number).first || new
  	  issue.year = year
  	  issue.volume = volume
  	  issue.number = number
  	  issue.save!
  	  Publication.import_old(xml.css("article"), issue.id)
  	else
  	  year = xml.at_css("issue dateUni").content
  	  volume = xml.at_css("issue volume").content
  	  number = xml.at_css("issue number").content
  	  issue = where(year: year, volume: volume, number: number).first || new
  	  issue.year = year
  	  issue.volume = volume
  	  issue.number = number
  	  issue.save!
      Publication.import(xml.css("article"), issue.id)
  	end
  end
end
