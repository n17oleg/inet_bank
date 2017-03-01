Rails.application.routes.draw do
  devise_for :users

  root to: 'bank_accounts#show'
end
