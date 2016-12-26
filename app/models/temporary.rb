class Temporary < Task
	validates :since, presence: true
	validates :until, presence: true
	validates_datetime :until, :after => :since
	validates_datetime :since, :before => :until

	default_scope -> { where("until >= ?", Time.now) }


end 