defmodule GenReport do
  def call do
    {:ok, data} = File.read("gen_report.csv")
    data
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x) end)
    |>List.first()
  end
end
