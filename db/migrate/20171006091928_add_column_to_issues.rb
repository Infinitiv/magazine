class AddColumnToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :score, :integer, default: 0
  end
end
