Rails.application.routes.draw do

  root 'topics#index' #トップ画面

  get '/index' => 'top#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:index, :show] #ユーザー一覧・詳細画面

  resources :conversations do
    resources :messages
  end

  resources :relationships, only: [:create, :destroy]

  resources :topics do #トピック
    resources :comments #コメント
  end

  resources :contacts, only: [:new, :create] do #お問い合わせ
    collection do
      get 'confirm'
    end
  end



end
