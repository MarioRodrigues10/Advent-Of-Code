defmodule Day03_Part2 do
  def part2(input) do
    input
    |> parse_input()
    |> find()
    |> multiply_ratios()
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.with_index()
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({%{}, []}, fn {simb, nums}, {simb_acc, nums_acc} ->
      {Map.merge(simb, simb_acc), nums ++ nums_acc}
    end)
  end

  defp parse_line({line, index}) do
    line
    |> parse_line(0, [])
    |> Enum.reduce({%{}, []}, fn {first, last, num}, {simb, nums} ->
      if is_number(num) do
        {simb, [{index, first, last, num} | nums]}
      else
        {Map.put(simb, {index, first}, num), nums}
      end
    end)
  end

  defp parse_line("", _pos, acc) do
    acc
  end

  defp parse_line(<<".", rest::binary>>, pos, acc), do: parse_line(rest, pos + 1, acc)

  defp parse_line(<<digit::binary-1, _::binary>> = lineN, pos, acc)
       when digit in ~w(0 1 2 3 4 5 6 7 8 9) do
    [_, num, rest] = Regex.run(~r{^(\d+)(.*)}, lineN)
    new_pos = pos + String.length(num)
    parse_line(rest, new_pos, [{pos, new_pos - 1, String.to_integer(num)} | acc])
  end

  defp parse_line(<<sim::binary-1, rest::binary>>, pos, acc) do
    parse_line(rest, pos + 1, [{pos, pos, sim} | acc])
  end

  def multiply_ratios(gears) do
    Enum.map(gears, fn {_, rt} -> Enum.product(rt) end)
  end

  defp find({simbs, nums}) do
    nums
    |> Enum.reduce(%{}, fn number, gears2 ->
      {_, _, _, rt} = number

      number
      |> positions()
      |> Enum.filter(&(Map.get(simbs, &1) == "*"))
      |> Enum.reduce(gears2, fn gear, gears ->
        Map.update(gears, gear, [rt], &[rt | &1])
      end)
    end)
    |> Enum.filter(fn {_, rts} -> length(rts) == 2 end)
  end

  def positions({index, first, last, _}) do
    line =
      if index > 0 do
        for pos <- (first - 1)..(last + 1), do: {index - 1, pos}
      else
        []
      end

    next_line = for pos <- (first - 1)..(last + 1), do: {index + 1, pos}

    [
      {index, first - 1},
      {index, last + 1}
    ] ++ line ++ next_line
  end
end

result = Day03_Part2.part2(File.read!("input.txt"))
IO.puts(result)
