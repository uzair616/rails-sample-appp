Rails.application.routes.draw do
  root to: 'application#index'

  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations },
                       path_names: { sign_in: :login }

    post 'send_invitation', to: 'invitations#create', as: :users_invitation
  end
end
