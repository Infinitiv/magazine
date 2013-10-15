class SearchController < ApplicationController
  def index
    @search = ThinkingSphinx.search params[:search], :page => params[:page], :per_page => 30
  end
end