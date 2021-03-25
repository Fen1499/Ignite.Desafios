defmodule Exflight.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys
  defstruct @keys

  #separar a data para facilitar a validação
  def build(ano, mes, dia, cidade_origem, cidade_destino, id_usuario) when is_integer(ano) and is_integer(dia) and is_integer(mes) do
    with {:ok, data} <- Date.new(ano, mes, dia),
         {:ok, hora} <- Time.new(0, 0, 0)  do

      {:ok, data_completa} = NaiveDateTime.new(data, hora)
      {
        :ok,
        %__MODULE__{
          id: UUID.uuid4(),
          data_completa: data_completa,
          cidade_origem: cidade_origem,
          cidade_destino: cidade_destino,
          id_usuario: id_usuario
        }
      }
    end
  end

  #vou deixar isso aqui se precisar
  def build(_ano, _dia, _mes, _cidade_origem, _cidade_destino, _id_usuario), do: {:error, "Invalid parameters!"}
end
