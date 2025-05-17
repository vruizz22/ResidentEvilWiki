Rails.application.routes.draw do
  get '/blogs/moderar', to: 'blogs#moderar', as: 'blogs_moderar'
  patch '/blogs/:id/moderar', to: 'blogs#actualizar_estado', as: 'moderar_blog'
  get '/mis_blogs', to: 'blogs#mis_blogs', as: 'mis_blogs'
  get '/blogs/:id/editar_rechazado', to: 'blogs#editar_rechazado', as: 'editar_rechazado_blog'
  patch '/blogs/:id/reenviar_moderacion', to: 'blogs#reenviar_moderacion', as: 'reenviar_moderacion_blog'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }, 
  path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get '/edit', to: 'controller_name#edit', as: 'edit'
  # Ruta raíz
  root 'home#index'
  resources :blogs
  resources :solicitudes_edicion, as: "solicitud_edicion", path: "solicitudes_edicion", only: [:new, :create, :index, :update, :show]
end
