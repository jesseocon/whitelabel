class AddIndexToSiteName < ActiveRecord::Migration[5.1]
  def change
    add_index :sites, :name, unique: true
    add_index :sites, :slug, unique: true
    add_index :templates, :theme_id
    add_index :themes, :name, unique: true
    add_index :javascripts, :theme_id
    add_index :site_themes, [:theme_id, :site_id]
    add_index :stylesheets, [:theme_id]
  end
end
