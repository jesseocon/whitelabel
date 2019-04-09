class ChangeSiteThemeUserIdToSiteId < ActiveRecord::Migration[5.1]
  def change
    rename_column :site_themes, :user_id, :site_id
  end
end
