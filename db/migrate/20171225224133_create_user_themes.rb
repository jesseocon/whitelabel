class CreateUserThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_themes do |t|
      t.belongs_to :theme
      t.belongs_to :user
      t.boolean :active

      t.timestamps
    end
  end
end
