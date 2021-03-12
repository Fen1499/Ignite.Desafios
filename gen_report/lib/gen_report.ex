
defmodule GenReport do

  #Comecei aqui, meio sem ideia do que fazer depois de transformar o arquivo em uma lista de listas
  def call do
    {:ok, data} = File.read("gen_report.csv") #nome, horas, dia, mes, ano

    data
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, ",") end)
    #|> Enum.map(fn x -> all_hours(x) end)
    #|> sum_hours()
    |> hours_per_month()

    #Alguma coisa que extrai o valor de lists em uma função recursiva, sei lá
    #|>List.first()
  end

   #Esse foi o primeiro que eu comecei
   def all_hours([name, hours, _day, _month, _year]) do
    %{
      String.to_atom(name) => String.to_integer(hours)
    }
  end

  def sum_hours([m = %{}]), do: m
  def sum_hours([head = %{}|tail]) do
    Map.merge(head, sum_hours(tail), fn _k, v1, v2 -> v1 + v2 end) #Isso funciona, mas depois eu confiro no python
  end



  #Isso aqui só aconteceu kkk
  #Inicialmente essa função se chamava hard_merge
  def hours_per_month(m_list) do
    Enum.group_by(m_list,
      fn [name, _hours, _day, _month, _year] -> name end,
      fn [_name, hours, _day, month, _year] -> %{String.to_atom(month) => String.to_integer(hours)} #Mapear o month para extenso aqui
    end)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), sum_hours(v)} end) #descobri que pra decompor um mapa é {k, v} e não {k => v}
  end
end

#Meu primeiro objetivo foi decompor o arquivo em uma lista de listas
#Depois comecei a procurar como transformar ela no formato desejado
#Comecei pelo all_hours, depois sum_hours quando eu vi deu certo(eu acho)
