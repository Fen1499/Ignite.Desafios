defmodule Exapi.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :exapi,
  module: Exapi.Tokens,
  error_handler: Exapi.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  end
