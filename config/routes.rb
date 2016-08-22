Rails.application.routes.draw do

  root to: 'top#index' #トップ画面

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }  #ログイン・サインアップ

  resources :users, only: [:index, :show] #ユーザー一覧・詳細画面

  resources :topics do #トピック
    resources :comments #コメント
  end

  resources :contacts, only: [:new, :create] do #お問い合わせ
    collection do
      get 'confirm'
    end
  end



end
