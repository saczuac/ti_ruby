class List 
	include ActiveModel::Model

	attr_accessor :name, :url, :update

	validates :name, presence: true
	validates :url, presence: true

	def initialize(name = nil)
		self.name = name
		unless name.nil? 
			self.url = List.to_slug(name)
		end
		self
	end
end