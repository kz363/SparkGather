class UsersController < ApplicationController
	MOBILE_DEVICES = /(iPhone|iPod|iPad|Android|Phone|IEMobile|Tablet|Mobile|Nokia)/

	def index
		puts Cache.methods.sort
		@company_info = User.company_info
	end

	def gather
		redirect_to info_error_path if params[:c] == "" || params[:c] == nil
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
		Cache.update
		render nothing: true
	end

	def company
		@company = Users::CompanyPresenter.new(params[:c])
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def mobile_browser?
		request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][MOBILE_DEVICES] ? true : false
	end

	def user_info_params
		params.require(:user_info).permit!
	end
end
