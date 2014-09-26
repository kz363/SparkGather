class OnlyAjaxRequest
	def matches?(request)
		request.xhr?
	end
end

SparkGather::Application.routes.draw do
	root 'users#index'
	get '/users/:id' => 'users#show', as: 'user'
	get '/users' => 'users#company'
	get '/info' => 'users#gather'
	put '/update' => 'users#update', :constraints => OnlyAjaxRequest.new
	get '/speedtest' => 'users#speedtest', :constraints => OnlyAjaxRequest.new
end
