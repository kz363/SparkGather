class UsersController < ApplicationController
	MOBILE_DEVICES = /(iPhone|iPod|iPad|Android|Phone|IEMobile|Tablet|Mobile|Nokia)/
	BROWSERS = /(opera|chrome|safari|firefox|msie|trident)\/[^ ]*/i
	OPERATING_SYSTEMS = /(Mac|Windows|Linux|Android|CPU|Blackberry) \w[^;)]*/i

	def index
		@company_info = User.company_info
	end

	def gather
		if params[:c] == "" || params[:c] == nil
			redirect_to info_error_path
		elsif cookies[:guidespark_id]
			@user = User.find(cookies.signed[:guidespark_id]) # runs into error when database is empty
		else
			company = SymmetricEncryption.decrypt(params[:c])
			salesforce_id = SymmetricEncryption.decrypt(params[:sfid])
			user_agent = request.env['HTTP_USER_AGENT']
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
													salesforce_id: salesforce_id,
													mobile: mobile_browser?)
			cookies.signed[:guidespark_id] = { value: @user.id, expires: 7.days.from_now }
		end
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

	def encrypt
		# parse params here
		#  remember to titleize the name
		params[:link_form]
		company_name = params[:link_form][:company_name].titleize
		salesforce_id = params[:link_form][:salesforce_id]
		puts "\n\n\n\n\n"
		url =	info_url +
				'/?c=' + strip_encrypted(SymmetricEncryption.encrypt("#{company_name}")) + '&' +
				'sfid=' + strip_encrypted(SymmetricEncryption.encrypt("#{strip_encrypted(salesforce_id)}"))
		render json: { url: url }
	end

	def link
		@link_form = LinkForm.new
	end

private

	def strip_encrypted(encryption)
		encryption.gsub(/\n/, '')
	end

	def mobile_browser?
		request.env['HTTP_USER_AGENT'] && request.env['HTTP_USER_AGENT'][MOBILE_DEVICES] ? true : false
	end

	def user_info_params
		params.require(:user_info).permit!
	end

	def parse_browser(user_agent)
		BROWSERS.match(user_agent).to_s.gsub('/', ' ')
	end

	def parse_operating_system(user_agent)
		OPERATING_SYSTEMS.match(user_agent).to_s
	end
end
