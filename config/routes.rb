Rails.application.routes.draw do
  root to: 'links#index', as: 'home'

  get    '/favourites', to: 'links#index',    as: 'favourites'
  get    '/unread',     to: 'links#index',    as: 'unread'
  get    '/links/new',  to: 'links#new',      as: 'new_link'
  post   '/links',      to: 'links#create',   as: 'create_link'
  get    '/links/:uid', to: 'links#show',     as: 'show_link'
  put    '/links/:uid', to: 'links#update',   as: 'update_link'
  delete '/links/:uid', to: 'links#destroy',  as: 'destroy_link'
  get    '/:uid',       to: 'links#redirect', as: 'redirect_link'

  get '/tags/:name', to: 'tags#show', as: 'show_tag'

  devise_for :users
end
