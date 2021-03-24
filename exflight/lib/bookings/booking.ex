defmodule Exflight.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys
  defstruct @keys

  #separar a data para facilitar a validação
  def build(ano, mes, dia, cidade_origem, cidade_destino, id_usuario) do
    data_completa =
      Date.new(ano, mes, dia) #aqui é garantido um ok pela validação do build
      |>NaiveDateTime.new(Time.new(0, 0, 0, 0))

    {
      :ok,
      %__MODULE__{
        id: 1,
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        id_usuario: id_usuario
      }
    }
  end
  def build(_data_completa, _cidade_origem, _cidade_destino, _id_usuario), do: {:error, "Invalid parameters!"}
end
