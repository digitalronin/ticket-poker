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

    get "/", TeamController, :new

    resources "/teams", TeamController
    resources "/tickets", TicketController do
      get "/estimate/:coder/:points", EstimateController, :update
    end
  end

  scope "/api", TicketPoker, as: :api do
    resources "/tickets", API.TicketController, only: [:show, :update]
  end
end
