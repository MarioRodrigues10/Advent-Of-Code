defmodule Day4_Part2 do
  def part2(input) do
    input = input |> String.split("\n", trim: true)

    cards1 =
      input
      |> Enum.map(&parse_line/1)
      |> Enum.with_index(1)

    card_count = length(cards1)

    cards2 = 1..card_count |> Stream.zip(cards1) |> Enum.into(%{})

    cards_seen(cards1, cards2, card_count)
  end

  defp parse_line(line) do
    line
    |> String.split(": ", trim: true)
    |> Enum.at(1)
    |> String.split("|")
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn nums -> Enum.map(nums, &String.to_integer(&1)) end)
    |> Kernel.then(fn [a, b] -> {a, b} end)
  end

  def cards_seen([], _, card_total), do: card_total
  def cards_seen([card | t], card_map, card_total) do
    {{winning, ours}, idx} = card

    matching =
      ours
      |> Enum.filter(&Enum.member?(winning, &1))
      |> Enum.count()

    case matching do
      0 ->
        cards_seen(t, card_map, card_total)

      _ ->
        v_cards =
          (idx + 1)..(idx + matching)
          |> Enum.map(fn i ->
            case Map.fetch(card_map, i) do
              {:ok, fetched_card} ->
                fetched_card

              :error ->
                nil
            end
          end)
          |> Enum.filter(&(&1 != nil))

        cards_seen(v_cards ++ t, card_map, card_total + matching)
    end
  end
end

result = Day4_Part2.part2(File.read!("input.txt"))
IO.puts("Part 2: #{result}")
