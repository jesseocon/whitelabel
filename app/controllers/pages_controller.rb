class PagesController < ApplicationController
  include SiteLocator
  before_action :find_public_site, only: [:index]

  def index
    @theme = @site.themes.find_by(active: true)
  end
end
