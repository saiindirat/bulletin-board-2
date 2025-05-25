Rails.application.routes.draw do
  devise_for :users

  root "boards#index"

  # CREATE
  post("/insert_board", { :controller => "boards", :action => "create" })
  post("/insert_post", { :controller => "posts", :action => "create" })

  # READ
  get("/boards", { :controller => "boards", :action => "index" })
  get("/boards/:path_id", { :controller => "boards", :action => "show" })

  get("/posts", { :controller => "posts", :action => "index" })
  get("/posts/:path_id", { :controller => "posts", :action => "show" })

  # UPDATE
  post("/modify_board/:path_id", { :controller => "boards", :action => "update" })
  post("/modify_post/:path_id", { :controller => "posts", :action => "update" })

  # DELETE
  get("/delete_board/:path_id", { :controller => "boards", :action => "destroy" })
  get("/delete_post/:path_id", { :controller => "posts", :action => "destroy" })
end

