class UsersController < ApplicationController
	def index
	end

	def gather
		company = params[:c]
		user_agent = request.env["HTTP_USER_AGENT"]
		ip = request.remote_ip
		browser = /(opera|chrome|safari|firefox|msie|trident)\/[^ ]*/i.match(user_agent).to_s.gsub("/", " ")
		os = /(Mac|Windows|Linux|Android|CPU|Blackberry) \w[^;)]*/i.match(user_agent).to_s
		proxy = Proxy.check_proxy(ip)
		@user = User.create(company: company,
							  user_agent: user_agent,
							  ip_address: ip,
							  browser: browser,
							  operating_system: os,
							  proxy: proxy,
							  mobile: mobile_browser?)
		puts "CHECK MOBILE?\n\n\n\n"
		p mobile_browser?
		# render whatever
	end

	def update
		puts "Spitting out paramssss"
		p params
		render nothing: true
	end

	private

	def mobile_browser?
		request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod|iPad|Android)/] ? true : false
	end
end
