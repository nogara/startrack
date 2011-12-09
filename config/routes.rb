Startrack::Application.routes.draw do

  devise_for :users

  resources :projects, :shallow => true  do
    resources :tasks, :except => [:index] do
      match "/change_status/:status_id" => "tasks#change_status", :as => :change_status, :on => :member
      resources :comments, :only => [:create, :destroy]
    end
  end

  root :to => "projects#index"
end
