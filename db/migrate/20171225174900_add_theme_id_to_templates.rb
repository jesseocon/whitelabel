class AddThemeIdToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :theme_id, :integer
  end
end
