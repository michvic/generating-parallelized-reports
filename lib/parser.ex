defmodule WorkingHoursReport.Parser do
  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(&convert_map/1)
  end

  defp convert_map(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> parse_line()
  end

  defp parse_line(line) do
    line = List.update_at(line, 1, &String.to_integer/1)
    line = List.update_at(line, 2, &String.to_integer/1)
    line = List.update_at(line, 3, &String.to_integer/1)
    line = List.update_at(line, 4, &String.to_integer/1)
  end
end
