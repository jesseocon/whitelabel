class AddSiteIdToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :site_id, :integer
    add_index :themes, :site_id
  end
end
