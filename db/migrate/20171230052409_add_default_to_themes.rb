class AddDefaultToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :default, :boolean, null: false, default: false
  end
end