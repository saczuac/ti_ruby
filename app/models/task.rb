class Task < ApplicationRecord
	validates :type, presence: true
	validates :description, presence: true
	validates :description, length: { maximum: 255, too_long: "%{count} characters is the maximum allowed" }

	belongs_to :state
	belongs_to :priority
	belongs_to :list

	validates :state, presence: true
	validates :priority, presence: true
	validates :list, presence: true

	self.inheritance_column = :type 
	
	def to_s
		description
	end

	default_scope -> { where("until IS NULL OR until >= ?", Time.now) }

	scope :larges, -> { where(type: 'Large') } 
	scope :simples, -> { where(type: 'Simple') } 
	scope :temporaries, -> { where(type: 'Temporary') } 
end
