defmodule GenReportAsync do
  def call do
    maps = ["part_1", "part_2", "part_3"]
    |>Enum.map(&gen_report_async(&1))
    |>Task.await_many()

    Enum.reduce(maps, %{}, &Map.merge(&1, &2, fn k, v1, v2 -> merger(k, v1, v2) end))
  end

  defp gen_report_async(file), do: Task.async(fn -> GenReportRmk.call(file) end)

  defp merger(k, m1, m2) do
    case k do
      :hours_per_month -> Map.merge(m1, m2, fn k, v1, v2 -> merger(k, v1, v2) end)
      :hours_per_year -> Map.merge(m1, m2, fn k, v1, v2 -> merger(k, v1, v2) end)
      _ -> Map.merge(m1, m2, fn _k, v1, v2 -> v1 + v2 end)

    end
  end

end
#11.000
#15.600
