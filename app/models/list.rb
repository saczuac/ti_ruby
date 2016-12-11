class List 
	include ActiveModel::Model
	include ActiveModel::Validations
  	include ActiveModel::Conversion
  	extend ActiveModel::Naming

	attr_accessor :name, :url, :updated_at, :created_at

	validates :name, presence: true
	validates :url, presence: true
	validates :created_at, presence: true
	validates :updated_at, presence: true

	def tasks
		Task.where("list = '#{self.id}'")
	end

	def initialize(name = nil, slug = nil)
		self.name = name
		self.url = slug
		self.created_at = Time.now
		self.updated_at = self.created_at
		self
	end

  def persisted?
    false
  end
end