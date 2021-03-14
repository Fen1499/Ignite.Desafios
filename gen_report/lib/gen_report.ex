
defmodule GenReport do

  #Comecei aqui, meio sem ideia do que fazer depois de transformar o arquivo em uma lista de listas
  def call do
    {:ok, data} = File.read("gen_report.csv") #nome, horas, dia, mes, ano

    list = data
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, ",") end)

    all_hours_key = list
    |> Enum.map(fn x -> all_hours(x) end)
    |> sum_hours()

    hours_per_month_key = hours_per_month(list)
    hours_per_year_key = hours_per_year(list)

    %{
      #all_hours: all_hours_key,
      hours_per_month: hours_per_month_key,
      #hours_per_year: hours_per_year_key
    }
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
      fn [_name, hours, _day, month, _year] -> %{month_morph(String.to_integer(month)) => String.to_integer(hours)} #manter int aqui ordena sozinho
    end)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), sum_hours(v)} end) #descobri que pra decompor um mapa é {k, v} e não {k => v}
  end

  #Levemente diferente de hours_per_month, eu sei que da pra unificar as duas mas talvez não faça isso, já gastei tempo demais
  def hours_per_year(m_list) do
    Enum.group_by(m_list,
      fn [name, _hours, _day, _month, _year] -> name end,
      fn [_name, hours, _day, _month, year] -> %{String.to_integer(year) => String.to_integer(hours)} #manter int aqui ordena sozinho
    end)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), sum_hours(v)} end) #descobri que pra decompor um mapa é {k, v} e não {k => v}
  end

  #Fui obrigado a fazer isso para ver se mapa vinha ordenado, não queria modificar o sum_hours
  #O elixir sempre ordena mapas em ordem alfabetica quando eles são pequenos, parece que não tem saida
  def month_morph(s = [_|_]) do
    Enum.sort(s)
    |>Enum.map(fn {k, v} -> %{month_morph(k) => v} end)
  end

  #A maneira mais eficiente seria keyfind(monthlist, n+1), mas acho que seria mais complicado
  #assim eu se que funciona
  def month_morph(s) do
    case s do
     1  -> String.to_atom("janeiro")
     2  -> String.to_atom("fevereiro")
     3  -> String.to_atom("marco")
     4  -> String.to_atom("abril")
     5  -> String.to_atom("maio")
     6  -> String.to_atom("junho")
     7  -> String.to_atom("julho")
     8  -> String.to_atom("agosto")
     9  -> String.to_atom("setembro")
     10  -> String.to_atom("outubro")
     11  -> String.to_atom("novembro")
     12  -> String.to_atom("dezembro")
    end
  end
end

#Meu primeiro objetivo foi decompor o arquivo em uma lista de listas
#Depois comecei a procurar como transformar ela no formato desejado
#Comecei pelo all_hours, depois sum_hours quando eu vi deu certo(eu acho)
#A parte de ordenar os meses demorou muito, no fim percebi que não tinha como
#Cheguei em um ponto que decidi que devia refazer que vai ser mais facil
