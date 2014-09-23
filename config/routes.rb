SparkGather::Application.routes.draw do

	get '/info' => 'users#gather', as: 'gather_path'
	
end
