defmodule Day4_Part1 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_card(&1))
    |> Enum.sum()
  end

  defp parse_card(game) do
    [_ | rounds] = String.split(game, ":")
    rounds = Enum.at(rounds, 0)

    [first, second] =
      rounds
      |> String.split(["|"])

    first = String.split(first, " ") |> Enum.reject(&(&1 == "")) |> Enum.map(&String.to_integer/1)

    second =
      String.split(second, " ") |> Enum.reject(&(&1 == "")) |> Enum.map(&String.to_integer/1)

    Enum.reduce(second, 0, fn number, acc ->
      if Enum.member?(first, number) do
        acc + 1
      else
        acc
      end
    end)
    |> calculate_points()
  end

  def calculate_points(0), do: 0
  def calculate_points(points), do: 2 ** (points - 1)
end

result = Day4_Part1.parse(File.read!("input.txt"))
IO.puts("Part 1: #{result}")
