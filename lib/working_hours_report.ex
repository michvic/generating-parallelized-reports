defmodule WorkingHoursReport do
  alias WorkingHoursReport.{AllHours, HoursPerMonth, HoursPerYear}

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
    all_hours = AllHours.build(filename, report_hours())
    hours_per_month = HoursPerMonth.build(filename, report_months())
    hours_per_year = HoursPerYear.build(filename, report_years())

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(report_acc(), fn {:ok, result}, report ->
        sum_reports(result, report)
      end)

    {:ok, result}
  end

  def sum_reports(
        %{
          all_hours: all_hours1,
          hours_per_month: hours_per_month1,
          hours_per_year: hours_per_year1
        },
        %{
          all_hours: all_hours2,
          hours_per_month: hours_per_month2,
          hours_per_year: hours_per_year2
        }
      ) do
    all_hours = merge_maps(all_hours1, all_hours2)

    hours_per_month =
      Enum.reduce(@devs, report_months(), fn name, report ->
        Map.put(report, name, merge_maps_by_name(hours_per_month1, hours_per_month2, name))
      end)

    hours_per_year =
      Enum.reduce(@devs, report_years(), fn name, report ->
        Map.put(report, name, merge_maps_by_name(hours_per_year1, hours_per_year2, name))
      end)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_maps_by_name(map1, map2, name) do
    Map.merge(map1[name], map2[name], fn _keys, value1, value2 -> value1 + value2 end)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _keys, value1, value2 -> value1 + value2 end)
  end

  def report_acc do
    all_hours = report_hours()
    hours_per_month = report_months()
    hours_per_year = report_years()

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp report_hours, do: Enum.into(@devs, %{}, &{&1, 0})

  defp report_months do
    months = Enum.into(@months_index, %{}, fn {_key, value} -> {value, 0} end)
    Enum.into(@devs, %{}, &{&1, months})
  end

  defp report_years do
    years = Enum.into(2016..2020, %{}, &{&1, 0})
    Enum.into(@devs, %{}, &{&1, years})
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      all_hours: all_hours,
      hours_per_month: hours_per_month,
      hours_per_year: hours_per_year
    }
  end
end
