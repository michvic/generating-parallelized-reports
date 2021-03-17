defmodule WorkingHoursReportTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "gen_test.csv"

      response = WorkingHoursReport.build(file_name)

      expected_response = %{
        all_hours: %{
          Cleiton: 27,
          Daniele: 16,
          Danilo: 7,
          Diego: 10,
          Giuliano: 13,
          Jakeliny: 25,
          Joseph: 0,
          Mayk: 23,
          Rafael: 15,
          Vinicius: 8
        },
        hours_per_month: %{
          Cleiton: %{
            abr: 5,
            ago: 0,
            dez: 6,
            fev: 0,
            jan: 0,
            jul: 7,
            jun: 1,
            mai: 0,
            mar: 0,
            nov: 0,
            out: 8,
            set: 0
          },
          Daniele: %{
            abr: 7,
            ago: 0,
            dez: 5,
            fev: 0,
            jan: 0,
            jul: 0,
            jun: 4,
            mai: 0,
            mar: 0,
            nov: 0,
            out: 0,
            set: 0
          },
          Danilo: %{
            abr: 1,
            ago: 0,
            dez: 0,
            fev: 6,
            jan: 0,
            jul: 0,
            jun: 0,
            mai: 0,
            mar: 0,
            nov: 0,
            out: 0,
            set: 0
          },
          Diego: %{
            abr: 0,
            ago: 4,
            dez: 0,
            fev: 0,
            jan: 0,
            jul: 0,
            jun: 0,
            mai: 0,
            mar: 6,
            nov: 0,
            out: 0,
            set: 0
          },
          Giuliano: %{
            abr: 0,
            ago: 0,
            dez: 0,
            fev: 9,
            jan: 0,
            jul: 0,
            jun: 0,
            mai: 4,
            mar: 0,
            nov: 0,
            out: 0,
            set: 0
          },
          Jakeliny: %{
            abr: 0,
            ago: 0,
            dez: 9,
            fev: 0,
            jan: 0,
            jul: 8,
            jun: 0,
            mai: 0,
            mar: 0,
            nov: 0,
            out: 8,
            set: 0
          },
          Joseph: %{
            abr: 0,
            ago: 0,
            dez: 0,
            fev: 0,
            jan: 0,
            jul: 0,
            jun: 0,
            mai: 0,
            mar: 0,
            nov: 0,
            out: 0,
            set: 0
          },
          Mayk: %{
            abr: 4,
            ago: 0,
            dez: 5,
            fev: 0,
            jan: 0,
            jul: 0,
            jun: 0,
            mai: 0,
            mar: 3,
            nov: 4,
            out: 0,
            set: 7
          },
          Rafael: %{
            abr: 0,
            ago: 4,
            dez: 0,
            fev: 0,
            jan: 4,
            jul: 7,
            jun: 0,
            mai: 0,
            mar: 0,
            nov: 0,
            out: 0,
            set: 0
          },
          Vinicius: %{
            abr: 0,
            ago: 0,
            dez: 0,
            fev: 0,
            jan: 0,
            jul: 8,
            jun: 0,
            mai: 0,
            mar: 0,
            nov: 0,
            out: 0,
            set: 0
          }
        },
        hours_per_year: %{
          Cleiton: %{2016 => 0, 2017 => 5, 2018 => 13, 2019 => 0, 2020 => 9},
          Daniele: %{2016 => 5, 2017 => 0, 2018 => 7, 2019 => 0, 2020 => 4},
          Danilo: %{2016 => 0, 2017 => 0, 2018 => 1, 2019 => 6, 2020 => 0},
          Diego: %{2016 => 0, 2017 => 4, 2018 => 6, 2019 => 0, 2020 => 0},
          Giuliano: %{2016 => 0, 2017 => 3, 2018 => 0, 2019 => 6, 2020 => 4},
          Jakeliny: %{2016 => 8, 2017 => 9, 2018 => 0, 2019 => 6, 2020 => 2},
          Joseph: %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0},
          Mayk: %{2016 => 11, 2017 => 1, 2018 => 0, 2019 => 4, 2020 => 7},
          Rafael: %{2016 => 0, 2017 => 11, 2018 => 0, 2019 => 0, 2020 => 4},
          Vinicius: %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 8}
        }
      }

      assert response == expected_response
    end
  end
end
