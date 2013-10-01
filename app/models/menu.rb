class Menu < ActiveRecord::Base
  validates :title, :path, :weigth, :presence => true
  validates :path, :uniqueness => true
end
