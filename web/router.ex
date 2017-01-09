defmodule TicketPoker.Router do
  use TicketPoker.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TicketPoker do
    pipe_through :browser # Use the default browser stack

    get "/",       TeamController,  :new
    get "/teams",  TeamController,  :new

    resources "/teams", TeamController, except: [:index]
    resources "/tickets", TicketController do
      get "/estimate/:coder/:points", EstimateController, :update
    end
  end

  scope "/api", TicketPoker, as: :api do
    pipe_through :api
    resources "/tickets", API.TicketController, only: [:create]
  end
end
