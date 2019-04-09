class CreateJavascripts < ActiveRecord::Migration[5.1]
  def change
    create_table :javascripts do |t|
      t.string :name
      t.text :body
      t.integer :theme_id

      t.timestamps
    end
  end
end
