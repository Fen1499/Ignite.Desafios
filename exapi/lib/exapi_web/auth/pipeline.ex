defmodule Exapi.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :exapi,
  module: ExapiWeb.Auth.Guardian,
  error_handler: Exapi.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  end
