defmodule ExapiWeb.ApiController do
  use ExapiWeb, :controller
  alias Exapi.GitApi.Client

  def index(conn, params) do
    with {status, user_data} <- get_and_format(params) do
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
      {:error, _} ->
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
