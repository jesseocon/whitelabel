class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.json :settings_data
      t.json :settings_schema
      t.string :name

      t.timestamps
    end
  end
end
