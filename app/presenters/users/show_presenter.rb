class Users::ShowPresenter
	attr_reader :user
	def initialize(user)
		@user = user
	end

	def basic_info
		basic_info = [user.operating_system, ]
	end

	def connection
		connection = [user.ip_address]
	end
end
