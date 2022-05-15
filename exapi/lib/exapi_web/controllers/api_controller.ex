defmodule ExapiWeb.ApiController do
  use ExapiWeb, :controller
  alias Exapi.GitApi.Client

  def index(conn, params) do
    with {status, user_data} <- get_and_format(params) do
      {:ok, _, {new_token, _}} =
        conn
        |> Guardian.Plug.current_token()
        |> ExapiWeb.Auth.Guardian.refresh()
      IO.inspect(new_token)
      conn
      |>put_status(status)
      |>json(user_data)
    end
  end

  defp get_and_format(%{"username" => username}) do
    case Client.get_user_info(username) do
      {:ok, data} ->
        mapped = Enum.map(data, fn x -> format_list(x) end)
        {:ok, mapped}
      {:error, _} -> #Da pra melhorar, mas vou manter simples e objetivo
        {:not_found, %{"Message": "User not found"}}
    end
  end

  defp format_list(head = %{}) do
    %{
      "id" => head["id"],
      "name" => head["name"],
      "description" => head["description"],
      "html_url" => head["html_url"],
      "stargazers_count" => head["stargazers_count"]
    }
  end
end
