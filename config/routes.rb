SparkGather::Application.routes.draw do
  root 'users#index'
  get '/info' => 'users#gather', as: 'gather_path'
end
