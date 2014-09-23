SparkGather::Application.routes.draw do
  root 'users#index'
  get '/info/:c' => 'users#gather', as: 'gather_path'
  post '/update' => 'users#update'
end
