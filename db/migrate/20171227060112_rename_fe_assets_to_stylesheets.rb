class RenameFeAssetsToStylesheets < ActiveRecord::Migration[5.1]
  def change
    rename_table :fe_assets, :stylesheets
  end
end