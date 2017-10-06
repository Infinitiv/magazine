class PublicationsController < IssuesController
  skip_before_action :require_login, only: [:show]
  before_action :require_editor, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_issue, only: [:index, :show, :edit, :create, :update, :destroy]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  # GET /publications
  # GET /publications.json
  def index
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    Publication.record_timestamps = false
    @publication.score += 1
    @publication.save
    Publication.record_timestamps = true
    @attachment = Attachment.new
    @first_image_attachment = @publication.attachments.select {|a| a.mime_type =~ /image/}.first
    @image_attachments = @publication.attachments.select {|a| a.mime_type =~ /image/} - [@first_image_attachment]
    @not_image_attachments = @publication.attachments.select {|a| a.mime_type !~ /image/}
    @next_publication = @issue.publications.find_by_id(params[:id].to_i + 1)
    @previous_publication = @issue.publications.find_by_id(params[:id].to_i - 1)
  end

  # GET /publications/new
  def new
    @publication = @issue.publications.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = @issue.publications.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to :back, notice: 'Publication was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to issue_publication_url(@issue, @publication), notice: 'Publication was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to issue_url(@issue) }
    end
  end

  private
    def set_issue
      @issue = Issue.find(params[:issue_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = @issue.publications.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:title_ru, :title_en, :authors_ru, :authors_en, :keywords_ru, :keywords_en, :abstract_ru, :abstract_en, :issue_id)
    end
end
