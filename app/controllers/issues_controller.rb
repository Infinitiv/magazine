class IssuesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :require_editor, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_editor_permission, only: [:index, :show]
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = issues
    @years = Issue.all.map(&:year).uniq.sort
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    Issue.record_timestamps = false
    @issue.score += 1
    @issue.save
    Issue.record_timestamps = true
    @attachment = Attachment.new
    @publications = @issue.publications.order(:id)
    @publication = @issue.publications.new
    @first_image_attachment = @issue.attachments.select {|a| a.mime_type =~ /image/}.first
    @image_attachments = @issue.attachments.select {|a| a.mime_type =~ /image/} - [@first_image_attachment]
    @not_image_attachments = @issue.attachments.select {|a| a.mime_type !~ /image/}
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @issue }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

  def import
    Issue.import(params[:file])
    redirect_to :back, notice: "Import sucsess"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:year, :volume, :number)
    end

    def issues
      issues = {}
      years = Issue.all.map(&:year).uniq
      years.each do |year|
        issues[year] = Issue.order(:year, :volume, :number).where(year: year)
      end
      issues
    end
end
