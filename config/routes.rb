Rails.application.routes.draw do
  root to: "tasks#index"
  
  resources :tasks
  patch "tasks/:id/complete", to: "tasks#complete", as: "mark_complete"
end
