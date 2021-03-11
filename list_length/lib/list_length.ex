defmodule ListLength do

  #Isso foi a primeira coisa que eu fiz, queria criar casos de teste
  #Depois eu vi que isso criava um problema "resolvido"
  #Achei legal o código, vou manter
  def call do
    tamanho = Enum.random(1..50)
    lista = cria_lista(tamanho)
    %{tamanho: tamanho+1, tamanho_esperado: length(lista), lista: lista}
  end

  #Tive que procurar como fazer um match com uma lista de tamanho N, depois que voce ve é bem óbvio
  def call(lista = [_|_]) do
    conta(lista)
  end

  #Essa função cria a lista recursivamente
  #Nesse caso eu já sei o tamanho desde o incio!
  #Simplesmente aconteceu, só queria criar uma lista!!
  defp cria_lista(tamanho) do
    case tamanho do
      0 -> [Enum.random(1..999)]
      _ -> [Enum.random(1..999)] ++ cria_lista(tamanho - 1)
    end
  end

  #Descobri a existencia e utilidade de guards aqui
  #Acho que a unica maneira de dar match com [] e [_|_]
  #O enunciado diz uma lista de numeros, mas não somento de numeros
  defp conta(lista) when is_list(lista) do
    case lista do
      [] -> 0
      [_|tail] -> 1 + conta(tail)
    end
  end

end
