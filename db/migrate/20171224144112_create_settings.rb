class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.json :settings_data
      t.json :settings_schema

      t.timestamps
    end
  end
end
