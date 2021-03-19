defmodule WorkingHoursReport.HoursPerYear do
  alias WorkingHoursReport.Parser

  @devs [
    :Daniele,
    :Mayk,
    :Giuliano,
    :Cleiton,
    :Jakeliny,
    :Joseph,
    :Diego,
    :Danilo,
    :Rafael,
    :Vinicius
  ]
  def build(filename, report_years) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_years, fn line, report -> sum_hours_per_year(line, report) end)
  end

  defp sum_hours_per_year([name, hours, _day, _month, year], %{} = report_year_acc) do
    name = String.to_atom(name)
    year_map = report_year_acc[name]

    new_year_map =
      Map.put(
        year_map,
        year,
        year_map[year] + hours
      )

    %{report_year_acc | name => new_year_map}
  end
end
