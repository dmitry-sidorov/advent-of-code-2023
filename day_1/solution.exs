defmodule DayOne do
  @spelled_digits_map [
    {"one", "1"},
    {"two", "2"},
    {"three", "3"},
    {"four", "4"},
    {"five", "5"},
    {"six", "6"},
    {"seven", "7"},
    {"eight", "8"},
    {"nine", "9"},
  ]

  defp get_range_list(regex_index_list) do
    regex_index_list
    |> Enum.at(0)
    |> Enum.map(fn {start, length} -> {start, start + length - 1} end)
  end

  # need to solve intersection cases like:
  # {%{line: "2eightwos\n", parsed: [{"eight", [{1, 5}]}, {"two", [{5, 7}]}]}, 950}
  # "eight" should be parsed first, "two" should be skipped (symbol "t" is taken by "eight")
  defp ranges_intersection?(a, b) do

  end

  defp parse_spelled_numbers(line) do
    @spelled_digits_map
    |> Enum.map(fn ({spelled_digit, digit}) ->
      {spelled_digit, Regex.scan(~r/#{spelled_digit}/, line, return: :index)} end)
    |> Enum.reject(fn {_spelled_digit, indexes} -> length(indexes) == 0 end)
    |> Enum.map(fn {spelled_digit, indexes} -> {spelled_digit, get_range_list(indexes)} end)
    |> Enum.sort(fn ({_, a_range}, {_, b_range}) -> Enum.at(a_range, 0) > Enum.at(a_range, 0) end)
  end

  defp filter_digits(line) do
    line
    |> String.split("")
    |> Enum.reject(fn symbol -> String.match?(symbol, ~r/[a-z]|\n/) end)
    |> Enum.join()
  end


  # 54951 - first part
  def solve do
    File.stream!("source.txt")
    # |> Enum.map(fn line -> String.replace(line, "\n", "") end)
    |> Enum.map(fn line -> %{line: line, parsed: parse_spelled_numbers(line)} end)
    |> Enum.with_index
    # |> Enum.map(fn line -> String.replace(line, ~r/[a-z]/, "") end)
    |> Enum.each(&IO.inspect(&1))
    # |> Enum.map(&filter_digits/1)


    # |> Enum.map(fn line -> String.first(line) <> String.last(line) end)
    # |> Enum.map(fn pair -> String.to_integer(pair) end)
    # |> Enum.sum()
    # |> IO.inspect()
  end
end

DayOne.solve()
