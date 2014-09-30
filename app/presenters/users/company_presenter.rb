class Users::CompanyPresenter
	RECORDS_PER_PAGE = 10
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def users
		Rails.cache.read('users_info')[name].sort { |a,b| b.id <=> a.id }.each_slice(RECORDS_PER_PAGE).to_a
	end

	def metadata
		User.metadata(name)
	end
end
