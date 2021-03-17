defmodule WorkingHoursReport.ParserTest do
  use ExUnit.Case

  alias WorkingHoursReport.Parser

  describe "parse_file/1" do
    test "parses the file" do
      file_name = "gen_test.csv"

      response =
        file_name
        |> Parser.parse_file()
        |> Enum.map(& &1)

      expected_response = [
        ["Daniele", 7, 29, 4, 2018],
        ["Mayk", 4, 9, 12, 2019],
        ["Daniele", 5, 27, 12, 2016],
        ["Mayk", 1, 2, 12, 2017],
        ["Giuliano", 3, 13, 2, 2017],
        ["Cleiton", 1, 22, 6, 2020],
        ["Giuliano", 6, 18, 2, 2019],
        ["Jakeliny", 8, 18, 7, 2017],
        ["Mayk", 7, 3, 9, 2016],
        ["Danilo", 6, 28, 2, 2019],
        ["Diego", 4, 15, 8, 2017],
        ["Cleiton", 8, 3, 10, 2020],
        ["Giuliano", 4, 24, 5, 2020],
        ["Rafael", 7, 1, 7, 2017],
        ["Danilo", 1, 7, 4, 2018],
        ["Cleiton", 7, 2, 7, 2018],
        ["Mayk", 4, 27, 4, 2020],
        ["Mayk", 3, 18, 3, 2020],
        ["Jakeliny", 2, 5, 10, 2020],
        ["Mayk", 4, 9, 11, 2016],
        ["Jakeliny", 1, 29, 12, 2019],
        ["Diego", 6, 30, 3, 2018],
        ["Jakeliny", 8, 24, 12, 2016],
        ["Jakeliny", 5, 3, 10, 2019],
        ["Daniele", 4, 20, 6, 2020],
        ["Jakeliny", 1, 3, 10, 2017],
        ["Rafael", 4, 30, 1, 2017],
        ["Rafael", 4, 3, 8, 2020],
        ["Cleiton", 5, 9, 4, 2017],
        ["Vinicius", 8, 29, 7, 2020],
        ["Cleiton", 6, 24, 12, 2018]
      ]

      assert response == expected_response
    end
  end
end
