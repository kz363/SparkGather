class Users::CompanyPresenter
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def users
		Rails.cache.read('users_info')[name].sort { |a,b| b.id <=> a.id }.to_a
	end

	def metadata
		User.metadata(name)
	end
end
