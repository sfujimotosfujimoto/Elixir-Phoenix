defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
        |> Enum.chunk(3)  # Enum.chunk(hex, 3)
        |> Enum.map(&mirror_row/1) # pass in a function with 1 arity
        |> List.flatten
        |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def pick_color(
    %Identicon.Image{hex: [r, g, b | _tail]} = image
  ) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
    # same as
    # hash = :crypto.hash(<:m></:m>d5, input)
    # :binary.bind_to_list(hash)
  end

end
