defmodule ExmealWeb.FallbackController do
  use ExmealWeb, :controller
  alias ExmealWeb.ErrorView

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
