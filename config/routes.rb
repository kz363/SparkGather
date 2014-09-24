SparkGather::Application.routes.draw do
  root 'users#index'
  get '/info' => 'users#gather'
  put '/update' => 'users#update'
end
