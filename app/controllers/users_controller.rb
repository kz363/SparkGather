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
		browser = parse_browser(user_agent)
		operating_system = parse_operating_system(user_agent)
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
		@user = User.find(params[:user_id])
		@user.update(user_info_params)
		Cache.update
		render :show, layout: false
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

	def parse_browser(user_agent)
		/(opera|chrome|safari|firefox|msie|trident)\/[^ ]*/i.match(user_agent).to_s.gsub("/", " ")
	end

	def parse_operating_system(user_agent)
		/(Mac|Windows|Linux|Android|CPU|Blackberry) \w[^;)]*/i.match(user_agent).to_s
	end
end
