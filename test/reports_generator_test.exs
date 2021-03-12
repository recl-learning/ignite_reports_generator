defmodule ReportsGeneratorTest do
  use ExUnit.Case
  doctest ReportsGenerator

  describe "generate_report/1" do
    test "should generate a report based on a csv file" do
      filename = "report_test.csv"
      result = ReportsGenerator.generate_report(filename)

      expected = %{
        "all_hours" => %{
          "Cleiton" => 1,
          "Daniele" => 5,
          "Giuliano" => 9,
          "Jakeliny" => 8,
          "Joseph" => 3,
          "Mayk" => 5
        },
        "hours_per_month" => %{
          "Cleiton" => %{"junho" => 1},
          "Daniele" => %{"dezembro" => 5},
          "Giuliano" => %{"fevereiro" => 9},
          "Jakeliny" => %{"julho" => 8},
          "Joseph" => %{"março" => 3},
          "Mayk" => %{"dezembro" => 5}
        },
        "hours_per_year" => %{
          "Cleiton" => %{"2020" => 1},
          "Daniele" => %{"2016" => 5},
          "Giuliano" => %{"2017" => 3, "2019" => 6},
          "Jakeliny" => %{"2017" => 8},
          "Joseph" => %{"2017" => 3},
          "Mayk" => %{"2017" => 1, "2019" => 4}
        }
      }

      assert result == expected
    end
  end
end
