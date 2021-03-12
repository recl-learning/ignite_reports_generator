defmodule ReportsGenerator.Parser do
  @moduledoc """
  Module to parse reports from csv files
  """

  @doc """
  Parses a csv file into a list of lines. Each line is a list where each item is the column value.

  ## Examples
      iex> ReportsGenerator.Parser.parse_file("report_test.csv") |> Enum.map(& &1)
      [
        ["Mayk", "4", "9", "12", "2019"],
        ["Daniele", "5", "27", "12", "2016"],
        ["Mayk", "1", "2", "12", "2017"],
        ["Giuliano", "3", "13", "2", "2017"],
        ["Cleiton", "1", "22", "6", "2020"],
        ["Giuliano", "6", "18", "2", "2019"],
        ["Jakeliny", "8", "18", "7", "2017"],
        ["Joseph", "3", "17", "3", "2017"]
      ]

  """
  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(fn line -> trim_and_split_line(line) end)
  end

  defp trim_and_split_line(line) do
    line
    |> String.trim()
    |> String.split(",")
  end
end
