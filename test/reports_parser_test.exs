defmodule ReportsGeneratorParserTest do
  use ExUnit.Case, async: true
  alias ReportsGenerator.Parser
  doctest ReportsGenerator.Parser

  test "should parse a file" do
    filename = "report_test.csv"
    returned = Parser.parse_file(filename) |> Enum.map(fn x -> x end)

    expected = [
      ["Mayk", "4", "9", "12", "2019"],
      ["Daniele", "5", "27", "12", "2016"],
      ["Mayk", "1", "2", "12", "2017"],
      ["Giuliano", "3", "13", "2", "2017"],
      ["Cleiton", "1", "22", "6", "2020"],
      ["Giuliano", "6", "18", "2", "2019"],
      ["Jakeliny", "8", "18", "7", "2017"],
      ["Joseph", "3", "17", "3", "2017"]
    ]

    assert returned == expected
  end
end
