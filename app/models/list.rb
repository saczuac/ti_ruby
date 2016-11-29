class List < ApplicationRecord
	validates :name, :url, presence: true
	validates :name, :url, length: { maximum: 50, too_long: "%{count} characters is the maximum allowed" }

	def to_s
		name
	end
end
