class User < ActiveRecord::Base
	validates_presence_of :company

	def self.company_info
		company_info = []
		Rails.cache.read('users_info').map do |company, users|
			company_info << [company, users.count, users.max_by(&:updated_at).updated_at.localtime]
		end
		company_info.sort_by{ |name| name[0] }
	end

	def self.metadata(company)
		metadata = {}
		metadata[:common_os] = Rails.cache.read('users_info')[company].group_by(&:operating_system).max_by{ |c,u| u.count }[0]
		metadata[:common_browser] = Rails.cache.read('users_info')[company].group_by(&:browser).max_by{ |c,u| u.count }[0]
		metadata
	end

	def show_plugins
		return plugins.split('; ').inject([]) { |all_plugins, p| all_plugins << p.split(": ") } if plugins
		[]
	end

	def show_proxy
		case proxy
		when '0'
			'No proxy detected'
		when 'tor'
			'Client is behind Tor'
		when 'public'
			'Client is using a public proxy'
		else
			'ERROR'
		end
	end
end
