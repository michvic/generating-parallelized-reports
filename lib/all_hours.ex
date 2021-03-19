defmodule WorkingHoursReport.AllHours do
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
  def build(filename, report_hours) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_hours, fn line, report -> sum_all_hours(line, report) end)
  end

  defp sum_all_hours(
         [name, hours, _day, _month, _year],
         %{} = report_hours_acc
       ) do
    name = String.to_atom(name)

    Map.put(
      report_hours_acc,
      name,
      report_hours_acc[name] + hours
    )
  end
end
