class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :destroy]
  before_action :require_administrator, only: [:index]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
      send_data @attachment.data, :filename => @attachment.name, :type => @attachment.mime_type, :disposition => "inline"
  end

  # POST /attachments
  # POST /attachments.json
  def create      
      return if params[:attachment].blank?

      @attachment = Attachment.new
      @attachment.uploaded_file = params[:attachment]
      @attachment.thumbnail = thumb(@attachment.data, 150) if @attachment.mime_type =~ /image/
      @attachment.content = pdf2text(@attachment.data) if @attachment.mime_type =~ /pdf/

      if @attachment.save
	  flash[:notice] = "Thank you for your submission..."
	  redirect_to :back
      else
	  flash[:error] = "There was a problem submitting your attachment."
	  render :action => "new"
      end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def minify_img
      @attachment = Attachment.find(params[:id])
      send_data thumb(@attachment.data, 150), :filename => @attachment.name, :type => @attachment.mime_type, :disposition => "inline"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:title, :data, :mime_type, :thumbnail, :content)
    end
    
    def pdf2text(data)
      `pdftotext #{data} -`
    end
    
    def thumb(image, size)
      img = Magick::Image.from_blob(image).first
      img.resize_to_fill!(size).to_blob
    end
end
