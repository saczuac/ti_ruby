class Large < Task
	validates :percent, presence: true
	validates :percent, :inclusion => {:in => 0..100}

	def to_s
		percent
	end
end 