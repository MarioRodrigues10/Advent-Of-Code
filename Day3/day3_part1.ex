defmodule Day03_Part1 do
  def part1(filename) do
    File.stream!(filename)
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce({[], ""}, &find_numbers/2)
    |> fn {result, _} -> Enum.sum(result) end.()
  end

  defp find_numbers(lines, acc) do
    {result, last_line} = acc
    [line | next_line] = lines

  match = Regex.scan(~r/\d+/, line, return: :index)
    |> Enum.filter(fn [{first, count}] ->
        offset = count + min(0, first - 1)
        t = String.slice(last_line, max(0, first - 1), offset + 2)
        r = String.slice(line, first + count, 1)
        d = String.slice(Enum.at(next_line, 0) || "", max(0, first - 1), offset + 2)
        l = String.slice(line, max(0, first - 1), 1 + min(0, first - 1))

        Enum.any?([t, r, d, l], &symbol?/1)
      end)
    |> List.flatten
    |> Enum.map(fn {first, count} -> String.to_integer(String.slice(line, first, count)) end)

    {result ++ match, line}
  end

  defp symbol?(str) do
    Enum.any?(String.graphemes(str), fn c ->
      !Enum.member?([".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "\n"], c)
    end)
  end
end

result = Day03_Part1.part1("input.txt")
IO.inspect(result)
