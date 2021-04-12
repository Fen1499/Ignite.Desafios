defmodule ExmealWeb.Router do
  use ExmealWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExmealWeb do
    pipe_through :api

    resources "/meals", MealsController, except: [:new, :edit]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ExmealWeb.Telemetry
    end
  end
end
