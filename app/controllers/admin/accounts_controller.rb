class Admin::AccountsController < ApplicationController
  before_action :authenticate_user!

  def new
    @account = AccountCreationService.new({}, current_user)
  end

  def create
    @account = AccountCreationService.new(account_params, current_user)

    if @account.save
      redirect_to admin_themes_url(subdomain: @account.site.slug)
    else
      render :new
    end
  end

  def edit
    @account = AccountCreationService.new(account_params, current_user)
  end

  def update

  end

  def show

  end

  private
    def account_params
      params.require(:account).permit(:name)
    end

end
