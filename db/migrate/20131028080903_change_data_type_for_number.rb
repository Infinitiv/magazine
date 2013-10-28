class ChangeDataTypeForNumber < ActiveRecord::Migration
  def self.up
  	change_table :issues do |t|
  	  t.change :number, :string
  	end
  end
  def self.down
  	change_table :issues do |t|
  	  t.change :number, :number
  	end
  end
end
