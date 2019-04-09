class ChangeUserThemesToSiteThemes < ActiveRecord::Migration[5.1]
  def change
    rename_table :user_themes, :site_themes
  end
end
