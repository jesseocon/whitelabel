class DropSiteThemes < ActiveRecord::Migration[5.1]
  def change
    drop_table :site_themes
    drop_table :templates
    drop_table :stylesheets
    drop_table :javascripts
    drop_table :pages
    drop_table :projects
    remove_index :themes, name: 'index_themes_on_name'
  end
end
