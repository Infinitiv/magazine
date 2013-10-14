class Feedback < ActiveRecord::Base
	validates :question, :presence => true
end
