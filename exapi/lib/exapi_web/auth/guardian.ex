defmodule ExapiWeb.Auth.Guardian do
  use Guardian, otp_app: :exapi
  alias Exapi.User

  def authenticate(%{"id" => id, "password" => password}, _claims) do
    with {:ok ,%User{id: id, password_hash: hash}} <- Exapi.Users.Get.by_id(id),
        true <- Pbkdf2.verify_pass(password, hash),
        {:ok, token, _claims} <- encode_and_sign(id, %{},ttl: {30, :minute}) do
          {:ok, token}
        else
         {:error, message} -> {:error, %{message: message, code: "unauthorized"}}
      end
    end

    def subject_for_token(id, _claims) do
      {:ok, id}
    end

  def resource_from_claims(%{"sub" => id}) do
    resource = Exapi.get_user_by_id(id)
    {:ok,  resource}
  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

end
