Rails.application.routes.draw do
  devise_for :users

  root to: 'bank_accounts#show'

  resources :account_transactions, only: [:new, :create]
end
