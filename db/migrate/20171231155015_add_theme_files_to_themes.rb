class AddThemeFilesToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :theme_files, :json
    add_column :themes, :kind, :integer, default: 0
    add_column :themes, :active, :boolean, default: false
    add_index :themes, :kind
  end
end
