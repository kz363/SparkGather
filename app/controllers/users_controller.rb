class UsersController < ApplicationController
	def index
		@company_info = User.company_info
	end

	def gather
		company = params[:c]
		user_agent = request.env["HTTP_USER_AGENT"]
		ip_address = request.remote_ip
		browser = /(opera|chrome|safari|firefox|msie|trident)\/[^ ]*/i.match(user_agent).to_s.gsub("/", " ")
		operating_system = /(Mac|Windows|Linux|Android|CPU|Blackberry) \w[^;)]*/i.match(user_agent).to_s
		proxy = Proxy.check_proxy(ip_address)
		@user = User.create(company: company,
												user_agent: user_agent,
												ip_address: ip_address,
												browser: browser,
												operating_system: operating_system,
												proxy: proxy,
												mobile: mobile_browser?)
	end

	def update
		user = User.find(params[:user_id])
		user.update(user_info_params)
		render nothing: true
	end

	def show
		puts "show params! \n\n\n"
		p params
		# @users = User.records
		# temporarily using User.last(10) to build the show template.
		# the correct call should show all company records based on
		# company name params[:c]
		@users = User.last(20)
		@company = params[:c]
		@metadata = User.metadata(@company)
	end

	private

	def mobile_browser?
		request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod|iPad|Android)/] ? true : false
	end

	def user_info_params
		params.require(:user_info).permit!
	end
end
