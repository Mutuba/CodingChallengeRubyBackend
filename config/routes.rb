# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks do
      end

      resources :tasks do
        member do
          put :finish
        end
      end
    end
  end
end
