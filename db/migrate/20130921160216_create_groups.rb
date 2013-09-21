class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :administrator, default: false
      t.boolean :editor, default: false
      t.boolean :viewer, default: false

      t.timestamps
    end
  end
end
