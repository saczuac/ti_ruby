class Temporary < Task
	validates :since, presence: true
	validates :until, presence: true
	validates_datetime :until, :after => :since
	validates_datetime :since, :before => :until

	scope :actives, -> { where("until IS NULL OR until >= ?", Time.now) }

end 