class Admin::ThemesController < ApplicationController
  include SiteLocator
  before_action :authenticate_user!
  before_action :find_site

  def index
    @theme = @site.themes.find_by(active: true)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    @theme = @site.themes.find(params[:id])

    if template_obj_params[:id] == 'settings'
      @theme.settings_data = JSON.parse(template_obj_params[:template])
    else
      data = @theme.theme_files
      data[template_obj_params[:kind]][template_obj_params[:id]]["template"] = template_obj_params[:template]
      @theme.theme_files = data
    end

    if @theme.save
      redirect_to admin_themes_path(kind: template_obj_params[:kind], template_id: template_obj_params[:id])
    else
      render :edit
    end
  end

  def destroy
  end

  private
    def template_obj_params
      params.require(:template_obj).permit(:template_string, :id, :template, :kind)
    end
end
