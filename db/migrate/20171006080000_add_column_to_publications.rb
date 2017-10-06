class AddColumnToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :score, :integer, default: 0
  end
end
