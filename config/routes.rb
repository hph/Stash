Rails.application.routes.draw do
  authenticated do
    root to: 'links#index', as: 'home'
  end

  root to: 'application#index', as: 'marketing'

  devise_for :users
end
