class Task < ApplicationRecord
	validates :type, presence: true
	validates :description, presence: true
	validates :description, length: { maximum: 255, too_long: "%{count} characters is the maximum allowed" }
	validates :list, presence: true

	belongs_to :state
	belongs_to :priority

	validates :state, presence: true
	validates :priority, presence: true

	self.inheritance_column = :type 
	
	def to_s
		description
	end

	scope :larges, -> { where(type: 'Large') } 
	scope :temporaries, -> { where(type: 'Temporary') } 
end

class Large < Task
	validates :percent, presence: true

	def to_s
		percent
	end
end 

class Simple < Task; end 

class Temporary < Task
	validates :since, presence: true
	validates :until, presence: true
end 
