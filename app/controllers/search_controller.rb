class SearchController < ApplicationController
  skip_before_action :require_login
  def index
    @search = ThinkingSphinx.search params[:search], :page => params[:page], :per_page => 30
  end
end