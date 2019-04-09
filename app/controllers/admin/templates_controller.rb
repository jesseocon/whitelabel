class Admin::TemplatesController < ApplicationController
  include SiteLocator
  before_action :authenticate_user!
  before_action :find_site # comes from SiteLocator
  before_action :find_theme

  def new
    @template = @theme.create_template({"kind" => "templates"})
  end

  def create
    resp = @theme.insert_template(template_obj_params)
    if resp && @theme.save
      redirect_to admin_themes_path
    else
      @template = @theme.create_template(template_obj_params)
      render :new
    end
  end

  def edit
    @template = @theme.current_template(
      kind: params[:kind],
      template_id: params[:template_id]
    )
  end

  def update
    @template = @theme.current_template(
      kind: template_obj_update_params[:kind],
      template_id: template_obj_update_params[:id]
    )
    resp = @theme.update_template(template_obj_update_params)
    if resp && @theme.save
      redirect_to admin_themes_path
    else
      render :edit
    end
  end

  private
    def find_theme
      @theme = @site.themes.find(params[:theme_id])
    end

    def template_obj_update_params
      params.require(:template_obj).permit(:kind, :template, :id)
    end

    def template_obj_params
      params.require(:template_obj).permit(:kind, :template, :name)
    end
end
