Rails.application.routes.draw do
  devise_for :users


  # Rotas para clientes
  resources :clientes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :gerar_pdf   # Rota para gerar o PDF da lista de clientes
      get :gerar_csv
    end
  end

  # Rotas para filmes
  resources :filmes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :gerar_pdf  # Rota para gerar o PDF da lista de filmes
    end
  end

  # Rotas para categorias
  resources :categorias, only: [:index, :show] do
    resources :filmes, only: [:index]
  end

  # Rotas para emprestimos
  resources :emprestimos, only: [:index, :create, :new, :show, :edit, :update, :destroy]


  # Rotas para dashboard e autenticação
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root

    # Rota para gerar CSV dos filmes e clientes no dashboard
    get 'gerar_csv_filmes', to: 'dashboard#gerar_csv_filmes'
    get 'gerar_csv_clientes', to: 'dashboard#gerar_csv_clientes'
  end

  get "destroy", to: 'clientes#destroy'

  get "destroy_filme", to: 'filmes#destroy', as: :destroy_filme

  get "destroy_emprestimo", to: 'emprestimos#destroy', as: :destroy_emprestimo



  unauthenticated do
    root 'home#index', as: :unauthenticated_root
  end
end