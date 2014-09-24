class OnlyAjaxRequest
	def matches?(request)
		request.xhr?
	end
end

SparkGather::Application.routes.draw do
	root 'users#index'
	get '/info' => 'users#gather'
	put '/update' => 'users#update', :constraints => OnlyAjaxRequest.new
	get '/speedtest' => 'users#speedtest', :constraints => OnlyAjaxRequest.new
end