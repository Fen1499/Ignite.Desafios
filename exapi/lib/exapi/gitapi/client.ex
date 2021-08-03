defmodule Exapi.GitApi.Client do
  use Tesla
  alias Tesla.Env

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  @base_url "https://api.github.com"

  def get_user_info(username) do
    "#{@base_url}/users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:error, %Env{status: status, body: body}}) do
    {:error, {status, body}}
  end

  defp handle_get({:ok, %Env{} = env}) do
    {:error, env}
  end
end
