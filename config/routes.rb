Rails.application.routes.draw do
  authenticated do
    root to: 'links#index', as: 'home'
  end

  root to: 'application#index', as: 'marketing'

  get    '/links/new',  to: 'links#new',      as: 'new_link'
  post   '/links',      to: 'links#create',   as: 'create_link'
  get    '/links/:uid', to: 'links#show',     as: 'show_link'
  put    '/links/:uid', to: 'links#update',   as: 'update_link'
  delete '/links/:uid', to: 'links#destroy',  as: 'destroy_link'
  get    '/:uid',       to: 'links#redirect', as: 'redirect_link'

  devise_for :users
end
