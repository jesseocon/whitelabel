class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :subdomain
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
