defmodule ReportsGenerator do
  @moduledoc """
  A report generator for work hours reports.
  """

  alias ReportsGenerator.Parser

  @months %{
    "1" => "janeiro",
    "2" => "fevereiro",
    "3" => "março",
    "4" => "abril",
    "5" => "maio",
    "6" => "junho",
    "7" => "julho",
    "8" => "agosto",
    "9" => "setembro",
    "10" => "outubro",
    "11" => "novembro",
    "12" => "dezembro"
  }

  @doc """
  Generates a report of work hours by adding all hours, hours by month and hours by year.
  Uses a csv file as a data source.

  ## Examples

      iex> ReportsGenerator.generate_report("report_test.csv")
      %{
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
  """
  def generate_report(filename) do
    Parser.parse_file(filename)
    |> Stream.map(fn line -> make_report(line) end)
    |> Enum.reduce(report_acc(), fn report, acc -> merge_reports(report, acc) end)
  end

  defp merge_reports(left, right) do
    Map.merge(left, right, fn key, left_val, right_val ->
      merge_section(key, left_val, right_val)
    end)
  end

  defp merge_section(key, left, right) when key == "hours_per_month" or key == "hours_per_year" do
    Map.merge(left, right, fn key, left_val, right_val ->
      merge_section(key, left_val, right_val)
    end)
  end

  defp merge_section(_key, left, right) do
    Map.merge(left, right, fn _key, left_val, right_val -> left_val + right_val end)
  end

  defp report_acc() do
    %{
      "all_hours" => %{},
      "hours_per_month" => %{},
      "hours_per_year" => %{}
    }
  end

  defp make_report(attribute_list) do
    [name, hours, _day_of_month, month_of_year, year] = attribute_list
    month_name = Map.get(@months, month_of_year)

    hours = String.to_integer(hours)

    %{
      "all_hours" => %{
        name => hours
      },
      "hours_per_month" => %{
        name => %{
          month_name => hours
        }
      },
      "hours_per_year" => %{
        name => %{
          year => hours
        }
      }
    }
  end
end
