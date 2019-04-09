class RenameSiteSubdomainToSiteSlug < ActiveRecord::Migration[5.1]
  def change
    rename_column :sites, :subdomain, :slug
  end
end