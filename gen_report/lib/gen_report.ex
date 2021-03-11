defmodule GenReport do
  def call do
    {:ok, data} = File.read("gen_report.csv") #nome, horas, dia, mes, ano
    lists =
      data
      |> String.split("\r\n")
      |> Enum.map(fn x -> String.split(x, ",") end)

    #Alguma coisa que extrai o valor de lists em uma função recursiva, sei lá
    #|>List.first()
  end
end
