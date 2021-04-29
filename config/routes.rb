Rails.application.routes.draw do
  resources :todos
  post '/todos/:id/toggle', to: 'todos#toggle', as: :toggle_todo  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
