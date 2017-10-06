class Publication < ActiveRecord::Base
  belongs_to :issue
  has_and_belongs_to_many :attachments
  
  #validates :title_ru, :authors_ru, :keywords_ru, :abstract_ru, :issue_id, :presence => true
  
  def self.score
    [Attachment.joins(:publications).select("attachments.score").sum(:score), Publication.select(:score).sum(&:score)].sum
  end
  
  def self.import(xml, id)
    xml.each do |p|
      title_ru = ''
      title_en = ''
      authors_ru = []
      authors_en = []
      keywords_ru = []
      keywords_en = []
      abstract_ru = ''
      abstract_en = ''
      p.css("artTitle").each{|at| title_ru = at.content if at.attr("lang") == 'RUS'}
      publication = find_by_title_ru(title_ru) || new
      p.css("author").each{|a| a.css("individInfo").each{|ii| authors_ru << "#{ii.at_css("surname").content} #{ii.at_css("initials").content}" if ii.attr("lang") == 'RUS'}}
      publication.authors_ru = authors_ru.join(", ")
      p.css("author").each{|a| a.css("individInfo").each{|ii| authors_en << "#{ii.at_css("surname").content} #{ii.at_css("initials").content}" if ii.attr("lang") == 'ENG'}}
      publication.authors_en = authors_en.join(", ")
      publication.title_ru = title_ru
      p.css("artTitle").each{|at| publication.title_en = at.content if at.attr("lang") == 'ENG'}
      p.css("keyword").each{|kw| kw.content =~ /[a-z]/ ? keywords_en << "#{kw.content}" : keywords_ru << "#{kw.content}"}
      publication.keywords_ru = keywords_ru.join(", ")
      publication.keywords_en = keywords_en.join(", ")
      p.css("abstract").each{|as| publication.abstract_ru = as.content if as.attr("lang") == 'RUS'}
      p.css("abstract").each{|as| publication.abstract_en = as.content if as.attr("lang") == 'ENG'}
      publication.issue_id = id
      publication.save!
    end
  end

  def self.import_old(xml, id)
    xml.each do |p|
      title_ru = ''
      title_en = ''
      authors_ru = []
      authors_en = []
      keywords_ru = []
      keywords_en = []
      abstract_ru = ''
      abstract_en = ''
      p.css("arttitle").each{|at| title_ru = at.content if at.attr("lang") == 'RUS'}
      publication = find_by_title_ru(title_ru) || new
      p.css("author").each{|a| a.css("individInfo").each{|ii| authors_ru << "#{ii.at_css("surname").content} #{a.at_css("fname").content if a.at_css("fname")}" if ii.attr("lang") == 'RUS'}}
      publication.authors_ru = authors_ru.join(", ")
      p.css("author").each{|a| a.css("individInfo").each{|ii| authors_en << "#{ii.at_css("surname").content} #{a.at_css("fname").content if a.at_css("fname")}" if ii.attr("lang") == 'ENG'}}
      publication.authors_en = authors_en.join(", ")
      publication.title_ru = title_ru
      p.css("arttitle").each{|at| publication.title_en = at.content if at.attr("lang") == 'ENG'}
      p.css("keyword").each{|kw| keywords_ru << "#{kw.content}" if kw.parent.attr("lang") == 'RUS'}
      publication.keywords_ru = keywords_ru.join(", ")
      p.css("keyword").each{|kw| keywords_en << "#{kw.content}" if kw.parent.attr("lang") == 'ENG'}
      publication.keywords_en = keywords_en.join(", ")
      p.css("abstract").each{|as| publication.abstract_ru = as.content if as.attr("lang") == 'RUS'}
      p.css("abstract").each{|as| publication.abstract_en = as.content if as.attr("lang") == 'ENG'}
      publication.issue_id = id
      publication.save!
    end
  end
end
