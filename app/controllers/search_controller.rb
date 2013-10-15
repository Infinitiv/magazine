class SearchController < ApplicationController
  def index
    @search = ThinkingSphinx.search params[:search]
  end
end