class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :require_login
  before_action :set_editor_permission
  before_action :set_menu_and_path
  before_action :set_menus
  before_action :set_news
  before_action :set_last_issue
  before_action :set_locale
  before_action :set_score

  def current_user
    @current_user = User.find_by_id(session[:user_id])
    @current_user
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def require_login
    unless logged_in?
      flash[:error] = "You mast be logged in"
      redirect_to login_path
    end
  end
  
  def require_viewer
    unless current_user_viewer?
      flash[:error] = "You mast have viewer`s permissions"
      redirect_to :back
    end
  end
  
  def require_editor
    unless current_user_editor?
      flash[:error] = "You mast have editor`s permissions"
      redirect_to :back
    end
  end
  
  def require_administrator
    unless current_user_administrator?
      flash[:error] = "You mast have administrator`s permissions"
      redirect_to :back
    end
  end 
  
  def current_user_viewer?
    current_user.group.viewer unless current_user.nil?
  end
  
  def current_user_editor?
    current_user.group.editor unless current_user.nil?
  end

  def set_editor_permission
    @editor_permission = current_user_editor?
  end

  def current_user_administrator?
    current_user.group.administrator unless current_user.nil?
  end
  
  def set_menu_and_path
    @menu = Menu.new
    @url = request.path
  end
  
  def set_menus
    if current_user_administrator? 
      @menus = Menu.order(:weigth).all 
    else
      @menus = Menu.order(:weigth).where(private: false)
    end
  end
  
  def set_last_issue
    @last_issue = Issue.order(:year, :volume, :number).last
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_news
    @news = ArticleType.order('updated_at DESC').where(name: 'news').first.articles.limit(5)
  end
  
  def set_score
    @views = [Publication.select(:score).sum(:score), Issue.select(:score).sum(:score)].sum
    @downloads = [Attachment.select("attachments.score").joins(:publications).sum(:score), Attachment.select("attachments.score").joins(:issues).sum(:score)].sum
  end
end
