class ArticlesController < ApplicationController
  before_action :require_editor, only: [:edit, :update, :create, :destroy]
  before_action :set_editor_permission, only: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_article_types, only: [:new, :edit]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
    
    def set_article_types
      @article_types = ArticleType.order(:name).all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params[:article][:content_ru] = ReverseMarkdown.parse params[:article][:content_ru]
      params[:article][:content_en] = ReverseMarkdown.parse params[:article][:content_en]
      params[:article][:cut_content_ru] = ReverseMarkdown.parse params[:article][:cut_content_ru]
      params[:article][:cut_content_en] = ReverseMarkdown.parse params[:article][:cut_content_en]
      params.require(:article).permit(:title_ru, :title_en, :content_ru, :content_en, :article_type_id, :expire, :published, :cut_content_ru, :cut_content_en)
    end
    
    def set_editor_permission
      @editor_permission = current_user_editor?
    end
end
