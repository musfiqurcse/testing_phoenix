defmodule Ectoservice.Router do
  use Ectoservice.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Ectoservice.Auth , repo: Ectoservice.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ectoservice do
    pipe_through :browser # Use the default browser stack

    get "/", PageController,  :index
    get "/error/:id", PageController,  :error_dis
    resources "/users", UserController, only: [:index, :new, :create]
    get "/users/:id", UserController, :show
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/roles", RoleController
    resources "/permissionpages", PermissionPageController
     resources "/rolemappings", RoleMappingController
     get "/createpermission", PermissionPageController, :create_permission
     post "/createpermission", PermissionPageController, :submit_permission
     get "/file", PageController, :file_audio
     post "/file", PageController, :file_receive
     get "/file/go/:download", PageController, :download
     get "/test/:time", PageController, :testing
  end
  scope "/api", Ectoservice do
    pipe_through :browser
    get "/api/index", UserController, :processall
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ectoservice do
  #   pipe_through :api
  # end
end
