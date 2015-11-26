Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'blog/blog#index'

  get 'about' => 'blog/blog#about'
  get 'contact' => 'blog/blog#contact'
  get '/robots.:format' => 'pages#robots'

  resources :posts,
    controller: 'blog/posts',
    param: :slug,
    only: [:show, :index]

  get "/404" => "errors#not_found"
  get "/500" => "errors#internal_server_error"
end
