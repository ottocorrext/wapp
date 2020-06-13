Rails.application.routes.draw do
  root 'admin#index'

  resources :orders, only: [:index, :show], param: :number do
    put :cancel, on: :member
  end

  resources :reports, only: :index do
    collection do
      get :coupons
      get :sales
    end
  end
end
