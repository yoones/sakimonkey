SakiMonkey::Application.routes.draw do
  get "entries/show"

  resources :categories

  match "entries/:id/mark_read" => "feeds#mark_read_entry", as: "mark_read_entry"
  match "feeds/:id/mark_read" => "feeds#mark_read_feed", as: "mark_read_feed"
  # match "entries/:id/mark/unread" => "feeds#mark_unread_entry", as: "mark_unread_entry"

  match "feeds/dump" => "feeds#dump", as: "dump_feeds"
  match "feeds/update_all" => "feeds#update_all", as: "update_feeds"
  resources :feeds #, only: [:index, :show, :new, :create, :destroy]
  match "feeds/:id" => "feeds#show", as: "entries"

  root to: "feeds#last"
end
