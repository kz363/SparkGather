class User < ActiveRecord::Base
	validates_presence_of :company

	def self.company_info
		company_info = []
		Rails.cache.read('users_info').map do |company, users|
			company_info << [company, users.count, users.max_by(&:updated_at).updated_at]
		end
		company_info.sort_by{ |info| info[0] }
	end
end
