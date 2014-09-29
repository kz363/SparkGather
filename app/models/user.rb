class User < ActiveRecord::Base
	RECORDS_PER_PAGE = 5
	validates_presence_of :company
	before_save :update_empty_fields, :update_proxy

	def self.company_info
		company_info = []
		Rails.cache.read('users_info').map do |company, users|
			company_info << [company, users.count, users.max_by(&:updated_at).updated_at.localtime]
		end
		company_info.sort_by{ |name| name[0] }.each_slice(RECORDS_PER_PAGE).to_a
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

	private

	def update_proxy
		case self.proxy
		when '0'
			p = 'No proxy detected'
		when 'tor'
			p = 'Client is behind Tor'
		when 'public'
			p = 'Client is using a public proxy'
		else
			p = 'ERROR'
		end
		
		self.proxy = p
	end

	def update_empty_fields
		self.attributes.each do |name, value|
			self.update_attributes(name => "N/A") if value == ""
		end
	end
end
