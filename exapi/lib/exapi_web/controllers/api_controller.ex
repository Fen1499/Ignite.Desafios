defmodule ExapiWeb.ApiController do
  use ExapiWeb, :controller
  alias Exapi.GitApi.Client

  def index(conn, params) do
    %{"username" => username} = params
    Client.get_user_info(username)
  end
end
