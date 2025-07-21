Rails.application.routes.draw do
  # 認証関連（Devise）
  devise_for :users

  # トップページ
  root to: "posts#index"

  # マイページ(自作)
  get 'mypage', to: 'users#mypage', as: 'mypage'

  # ユーザー関連
  resources :users, only: [:show, :edit, :update, :destroy]

  # 投稿といいね（ネスト）
  resources :posts do
    resource :like, only: [:create, :destroy]
  end
  
  # 検索機能
  get "searches", to: "searches#index"

end