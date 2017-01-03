defmodule TicketPoker.Router do
  use TicketPoker.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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
end
