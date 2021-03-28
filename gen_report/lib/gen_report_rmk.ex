defmodule GenReportRmk do
  def call(filename) do
    {:ok, data} = File.read("#{filename}.csv") #nome, horas, dia, mes, ano

    list = data
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, ",") end)

    all_hours_key =
      Enum.map(list ,fn [name, hours, _day, _month, _year] -> make_map(String.to_atom(name), hours)  end)
      |> sum_hours()

    all_months_key =
      Enum.map(list ,fn [name, hours, _day, month, _year] -> make_map([name, month_morph(month)], hours)  end)
      |> sum_hours()
      |> Enum.to_list()
      |> Enum.map(fn {[n, m], v} -> [n, m] ++ [v] end)
      |> hard_group()
      |> Map.new()

    all_years_key =
      Enum.map(list ,fn [name, hours, _day, _month, year] -> make_map([name, year], hours)  end)
      |> sum_hours()
      |> Enum.to_list()
      |> Enum.map(fn {[n, y], v} -> [n, y] ++ [v] end)
      |> hard_group()
      |> Map.new()

    %{
      all_hours: all_hours_key,
      hours_per_month: all_months_key,
      hours_per_year: all_years_key,
    }
  end

  def hard_group(list) do
    Enum.group_by(list,
      fn [name, _key, _value] -> String.to_atom(name) end,
      fn [_name, key, value] -> %{String.to_atom(key) => value} end)
    |> Enum.flat_map(fn {k, v} -> %{k => re_merge(v)} end) #Acho que isso aqui foi desnecessario
  end

  def make_map(k, v), do: %{k => String.to_integer(v)}

  def re_merge([m = %{}]), do: m
  def re_merge([head = %{}|tail]) do
    Map.merge(head, re_merge(tail))
  end

  def sum_hours([m = %{}]), do: m
  def sum_hours([head = %{}|tail]) do
    Map.merge(head, sum_hours(tail), fn _k, v1, v2 -> v1 + v2 end)
  end

  def month_morph(s) do
    case s do
     "1"  -> "janeiro"
     "2"  -> "fevereiro"
     "3"  -> "marco"
     "4"  -> "abril"
     "5"  -> "maio"
     "6"  -> "junho"
     "7"  -> "julho"
     "8"  -> "agosto"
     "9"  -> "setembro"
     "10"  -> "outubro"
     "11"  -> "novembro"
     "12"  -> "dezembro"
    end
  end

end
