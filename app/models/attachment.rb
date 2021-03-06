class Attachment < ActiveRecord::Base
  require 'RMagick'
  has_and_belongs_to_many :publications
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :issues
  
    def uploaded_file=(incoming_file)
        self.title = incoming_file[:file].original_filename
        self.mime_type = incoming_file[:file].content_type
	if incoming_file[:file].content_type =~ /image/
	  img = Magick::Image.read(incoming_file[:file].tempfile.path).first
	  img.scale!(img.columns > img.rows ? 800 / img.columns.to_f : 800 / img.rows.to_f)
	  img.write(incoming_file[:file].tempfile.path)
	end
    self.data = incoming_file[:file].read
	self.content = pdf2text(incoming_file[:file].tempfile.path) if incoming_file[:file].content_type =~ /pdf/
    self.content = File.read(incoming_file[:file].tempfile.path) if incoming_file[:file].content_type =~ /xml/
    end

    def filename=(new_filename)
        write_attribute("filename", sanitize_filename(new_filename))
    end
    
    def title_sen_dot
      if %r{[.]} =~ title
	title.reverse.from((%r{[.].+} =~ title.reverse) + 1).reverse
      else
	title
      end
    end
    
    private
    def sanitize_filename(filename)
        #get only the filename, not the whole path (from IE)
        just_filename = File.basename(filename)
        #replace all non-alphanumeric, underscore or periods with underscores
        just_filename.gsub(/[^\w\.\-]/, '_')
    end
    
    def pdf2text(data)
      `pdftotext #{data} -`
    end
end
