Rails.application.routes.draw do
  devise_for :authors, :controllers => {:registrations => "registrations"}

  namespace :authors do
    get '' => 'homes#index'

    resources :posts do
      put 'publish' => 'posts#publish', on: :member
      put 'unpublish' => 'posts#unpublish', on: :member
    end

    resources :tags, only: [:index, :show]

    resources :categories
    resources :pages do
      put 'publish' => 'pages#publish', on: :member
      put 'unpublish' => 'pages#unpublish', on: :member
    end

    resources :events do
      put 'publish' => 'events#publish', on: :member
      put 'unpublish' => 'events#unpublish', on: :member
    end

  end

  scope module: 'users' do
    root 'home#index'

    get 'author/:id' => 'author#show', as: :author

    get 'page' => 'pages#index', as: :pages
    get 'page/:id' => 'pages#show', as: :page

    get 'blog' => 'posts#index', as: :posts
    get 'blog/:id' => 'posts#show', as: :post

    get 'event' => 'events#index', as: :events
    get 'event/:id' => 'events#show', as: :event


  end


end
