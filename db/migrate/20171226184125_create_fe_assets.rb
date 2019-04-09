class CreateFeAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :fe_assets do |t|
      t.string :name
      t.text :body
      t.integer :theme_id

      t.timestamps
    end
  end
end
