defmodule WorkingHoursReport do
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

  def build(filename) do
    all_hours =
      filename
      |> Parser.parse_file()
      |> Enum.reduce(report_hours(), fn line, report -> sum_all_hours(line, report) end)

    hours_per_month =
      filename
      |> Parser.parse_file()
      |> Enum.reduce(report_months(), fn line, report -> sum_hours_per_month(line, report) end)

    hours_per_year =
      filename
      |> Parser.parse_file()
      |> Enum.reduce(report_years(), fn line, report -> sum_hours_per_year(line, report) end)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  # defp report_acc do
  #   all_hours = Enum.into(@devs, %{}, &{&1, 0})
  #   hours_per_month = Enum.into(@devs, %{}, &{&1, report_months()})
  #   hours_per_year = Enum.into(@devs, %{}, &{&1, report_years()})

  #   %{all_hours: all_hours, hours_per_month: hours_per_month, hours_per_year: hours_per_year}
  # end

  defp report_hours, do: Enum.into(@devs, %{}, &{&1, 0})

  defp report_months do
    months = Enum.into(@months_index, %{}, fn {_key, value} -> {value, 0} end)
    Enum.into(@devs, %{}, &{&1, months})
  end

  defp report_years do
    years = Enum.into(2016..2020, %{}, &{&1, 0})
    Enum.into(@devs, %{}, &{&1, years})
  end

  # defp parser_atom(string), do: String.to_atom(string)

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

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      all_hours: all_hours,
      hours_per_month: hours_per_month,
      hours_per_year: hours_per_year
    }
  end
end
