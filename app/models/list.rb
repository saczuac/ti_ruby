class List < ApplicationRecord
	validates :title, presence: true
	validates :slug, presence: true
	validates :slug, uniqueness: true

	has_many :tasks

	def to_s
		title
	end
end
