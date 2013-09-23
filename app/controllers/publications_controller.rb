class PublicationsController < IssuesController
  before_action :require_editor, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_issue, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]
  before_action :set_editor_permission, only: [:index, :show]

  # GET /publications
  # GET /publications.json
  def index
    @publications = @issue.publications
    @publication = @issue.publications.new
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
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
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
        format.json { render action: 'show', status: :created, location: @publication }
      else
        format.html { render action: 'new' }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to issue_publications_url(@issue) }
      format.json { head :no_content }
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

    def set_editor_permission
      @editor_permission = current_user_editor?
    end
end
