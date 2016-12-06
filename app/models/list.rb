class List 
	include ActiveModel::Model

	attr_accessor :name, :url, :update

	validates :name, presence: true
	validates :url, presence: true
	validates :update, presence: true

	def initialize(name = nil)
		self.name = name
		self.update = DateTime.now
		unless name.nil? 
			self.url = List.to_slug(name)
		end
		self
	end

	def self.all
		# TODO buscar en session las listas.
		[]
	end

	def self.to_slug(name)
	    #strip the string
	    ret = name.strip
	    #blow away apostrophes
	    ret.gsub! /['`]/,""
	    # @ --> at, and & --> and
	    ret.gsub! /\s*@\s*/, " at "
	    ret.gsub! /\s*&\s*/, " and "
	    #replace all non alphanumeric, underscore or periods with underscore
	    ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  
	    #convert double underscores to single
	    ret.gsub! /-+/,"-"
	    #strip off leading/trailing underscore
	    ret.gsub! /\A[-\.]+|[-\.]+\z/,""
	    ret
  	end
end