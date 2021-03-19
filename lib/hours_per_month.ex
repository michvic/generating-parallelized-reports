defmodule WorkingHoursReport.HoursPerMonth do
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
  @months_index %{
    1 => :jan,
    2 => :fev,
    3 => :mar,
    4 => :abr,
    5 => :mai,
    6 => :jun,
    7 => :jul,
    8 => :ago,
    9 => :set,
    10 => :out,
    11 => :nov,
    12 => :dez
  }

  def build(filename, report_months) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_months, fn line, report -> sum_hours_per_month(line, report) end)
  end

  defp sum_hours_per_month(
         [name, hours, _day, month, _year],
         %{} = report_month_acc
       ) do
    name = String.to_atom(name)
    month_map = report_month_acc[name]

    new_list =
      Map.put(
        month_map,
        @months_index[month],
        month_map[@months_index[month]] + hours
      )

    %{report_month_acc | name => new_list}
  end
end
