class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :path
      t.integer :weigth
      t.boolean :private, :default => false

      t.timestamps
    end
  end
end
